class Estimation < BaseRequest

  require 'pert_estimation'
  require 'linear_estimation'


  set_table_name "estimations"

  default_scope :order => 'created_at desc'


  ######################################################

  belongs_to :baseline
  belongs_to :task
  belongs_to :estimator
  before_create :set_baseline_parameter

  has_many :work_actuals, :dependent => :destroy
  has_many :wp_actuals, :dependent => :destroy

  # after_create :set_task_id
  before_update :store_estimation_results
  after_initialize :initialize_and_extend

  accepts_nested_attributes_for :work_actuals, :allow_destroy => true
  accepts_nested_attributes_for :wp_actuals, :allow_destroy => true


  aasm_event :request do
    transitions :to => :requested, :from => [:new]
  end

  aasm_event :estimate do
    transitions :to => :estimated, :from => [:requested, :estimated]
  end


  ######################################################

  def initialize_and_extend
#      self.extend EstimationPert
    if new_record?
      self.etc_hours=100 if etc_hours.nil?
      self.etc_amount=0 if etc_amount.nil?
      self.pm_eac_amount=0 if pm_eac_amount.nil?
      self.actual_hours=0 if actual_hours.nil?
    end
    self.extent_estimation_type unless self.task.nil?

  end


  def estimation_validate
    errors.add_to_base("Please create baseline first") if self.task.estimated_baseline.nil?
  end

  def start_date
    self.work_actuals.first.start_date
  end

  def end_date
    self.work_actuals.last.start_date
  end


  ##### Handling of different estimation types

  def extent_estimation_type
    case self.task.estimation_type
      when 'pert'
        logger.info "----------------------- Extended estimation #{self.id} as PERT"
        self.extend PertEstimation
      when 'linear'
        logger.info "----------------------- Extended estimation #{self.id} as LINEAR"
        self.extend LinearEstimation

      else
        raise 'invalid estimation type on estimation'
    end
  end

  def store_estimation_results
    self.eac_hours=self.get_eac
    self.variance=self.get_variance
  end

  ######################################################################  

  #make sure the estimation is created for the latest baseline of the task
  def set_baseline_parameter
    logger.info "======== SET BASELINE ==== for #{self.baseline_id}=#{self.task.latest_baseline}"
    self.baseline_id = self.task.latest_baseline.id
  end

  def is_baseline?
    return false
  end

  def is_current?
    self==self.task.estimation
  end

  def is_latest?
    self==self.task.estimations.first and not self.task.wait_for_baseline?
  end

  def estimation_allowed?
    self.status==:requested
  end

  ############### Handling work_actuals ################################

  def build_wp_actuals
    my_wp_actuals=self.wp_actuals

    self.baseline.wps.each do |b|
      found=false
      my_wp_actuals.each do |e|
        found = true if e.wp==b
      end
      if not found then
        self.wp_actuals.build do |e|
          e.wp_id = b.id
          e.status = get_status_for_new_wp(b)
        end
      end
    end
  end

  def get_status_for_new_wp(wp)
    return :open if self.is_current? or self.task.estimation.nil?
    self.task.estimation.wp_actuals.each do |wp_actuals|
      return wp_actuals.status if wp_actuals.wp_id == wp.id
    end
    return :open
  end
  ############### Handling work_actuals ################################



  def build_new_work_actuals

    logger.info " build_works_for_estimation from #{self.task.d_start} to #{self.task.d_end}"

    self.task.d_start.step(self.task.d_end, WORK_TIME_FRAME) do |date|

      logger.info "Create work task/estimation #{task.id} / #{self.id}"

      self.work_actuals.build do |w|
        w.task_id = task.id
        w.start_date=date
        w.duration=WORK_TIME_FRAME
      end

    end #end of date

  end

  #number of all estimations done up to this current estimation
  def total_actual_hours
    self.task.estimations.sum('actual_hours', :conditions=>"id<=#{self.id}")
  end


  ##############################################################
  ############################## EV Calculation


  def schedule_dif
    self.baseline.pv(self)-self.total_actual_hours
  end

  def spi

    if self.ev==0 or self.total_actual_hours == 0 then
      res_spi = 0
    else
      res_spi = self.ev.to_f/self.baseline.pv(self).to_f

    end

    return res_spi

  end

  def cpi

    if self.ev==0 or self.total_actual_hours == 0 then
      res_cpi = 0
    else
      res_cpi = self.ev.to_f/self.total_actual_hours.to_f

    end

    return res_cpi

  end

  def get_sigma
    Math.sqrt(self.get_variance)
  end


  ##############################################################

# if new estimation is requested, all other requested estimations must be closed
  def implement_requested_status
    self.task.estimations.each do |e|
      if e!=self then
        e.close!  unless e.status==:closed  or e.status ==:final
      end
    end
  end


  def implement_closed_status

  end

  def implement_estimated_status

    # set myself as valid estimation for this task
    self.task.estimation_id=self.id
    self.task.save!
  end


end
