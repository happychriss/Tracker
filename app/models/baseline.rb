class Baseline < BaseRequest

  require 'pert_baseline'
  require 'linear_baseline'

  set_table_name "baselines"

  default_scope :order => 'created_at desc'

  has_many :estimations, :dependent => :destroy
  has_many :works, :dependent => :destroy
  has_many :wps, :dependent => :destroy

  belongs_to :task
  belongs_to :estimator

  after_initialize :init_baseline

  # before_destroy :check_baseline_on_destroy
#  after_create :set_task_id
  before_save :store_estimation_results

  accepts_nested_attributes_for :works, :allow_destroy => true
  accepts_nested_attributes_for :wps, :allow_destroy => true, :reject_if => proc { |attrs| attrs.any? { |k, v| v.blank? } }


  def self.create_with_task(task,only_effort)
    baseline=task.baselines.new
    baseline.estimator=task.latest_baseline.estimator unless task.latest_baseline.nil_or.estimator.nil?
    baseline.build_new_works
    baseline.build_new_wps(task.latest_baseline)
    baseline.request_only_effort if only_effort
    return baseline
  end

  #overwrite after_initialise
  def init_baseline

    if new_record?

      self.pm_eac_amount=0 if pm_eac_amount.nil?
      self.request_only_effort if (self.task.start.nil? or self.task.stop.nil?)

    end

    self.extent_estimation_type

  end


  ##### Handling of different estimation types

  def extent_estimation_type
    case self.task.estimation_type
      when 'pert'
        self.extend PertBaseline
      when 'linear'
        self.extend LinearBaseline
      else
        raise 'invalid estimation type on baseline'
    end
  end

  def store_estimation_results
    self.eac_hours=self.get_baseline_eac
    self.variance =self.get_baseline_variance
  end


  ################### baseline support #######################################

  def check_baseline_on_destroy

    if self.task.baseline_id==self.id then
      raise("You can not delete a current baseline")
    else
      #are there any estimations that have me as a baseline - dont delete me !
      if Estimation.count('id', :conditions => "baseline_id > #{self.id}") then
        raise("You can not delete a baseline with related estimations")
      end
    end
  end


  def is_baseline?
    return true
  end

  def is_current?
    self==self.task.baseline
  end

  def my_estimations
    self.estimations.find_all_by_estimator_id(self.estimator_id)
  end

  def estimation_allowed?
    self.status==:requested or self.status==:requested_only_effort
  end

  def effort_only?
    self.status == :requested_only_effort or self.status == :estimated_only_effort
  end

  ################### works logic #######################################

  ## create new works for the baseline

  def build_new_works

    return if self.status==:new_only_effort #estimation only, no schedule

    work_actual_array=self.task.work_actuals

    d1               = Date.last_monday(self.task.start)
    d2               = task.stop

    logger.info " build_works_for_baseline from #{d1} to #{d2}"

    d1.step(d2, 7) do |date|
      self.works.build do |w|
        w.start_date =date
        w.duration   =WORK_TIME_FRAME
        w.workhours  =Baseline.corresponding_work(work_actual_array, date).nil_or.workhours
        w.description=Baseline.corresponding_work(work_actual_array, date).nil_or.description
      end
    end
  end

# todo validate if this is correct    w.workhours.nil?
# do not access database
  def get_works_total_hours
    res_hours =0
    self.works.each do |w|
      res_hours+=w.workhours unless w.workhours.nil?
    end
    return res_hours
  end


  ##################### wps logic ###################################

  def build_new_wps(old_baseline)

    if not old_baseline.nil? then
      old_baseline.wps.each do |owp|
        self.wps.build do |wp|
          wp.name      =owp.name
          wp.o_estimate=owp.o_estimate
          wp.p_estimate=owp.p_estimate
          wp.m_estimate=owp.m_estimate
        end
      end
    else

      for i in 1..5
        self.wps.build do |b|
        end
      end
    end

  end

  #################### EV #################################################

  ### EV Calculation

  def pv(estimation=nil)

    if estimation.nil? then
      current_date = Date.today
    else
      current_date = estimation.work_actuals.last.start_date
    end

    my_pv=0

    logger.info "start pv #{current_date}"

    self.works.each do |w|
      if w.start_date <= current_date then
        my_pv+=+w.workhours
        logger.info "#{w.start_date} / #{my_pv}/ #{w.workhours}"
      end

    end
    logger.info "end pv"
    return my_pv
  end

  # pert sigma from all workpackages
  def get_baseline_sigma
    return Math.sqrt(self.get_baseline_variance)
  end

  #################################

  private


  # if baseline is closed, all estimations of the baseline must be closed also
  def implement_closed_status
    # when closing the baseline, close all estimations of the baseline
    self.estimations.each do |e|
      e.close! unless e.status ==:closed or e.status==:final
    end
  end

# if new baseline is requested, all other requested baselines must be closed
  def implement_requested_status
    self.task.baselines.each do |b|
      if b!=self and b.status!=:closed and b.status!=:final then
        b.close!
      end
      self.task.estimation_id=nil # no valid estimation anymore
      self.task.save!
    end
  end

  def implement_estimated_status

    # make myself valid estimation
    self.task.baseline_id=self.id

# this will not happen,
#    self.task.estimation_id=nil

    self.task.save!
  end


end