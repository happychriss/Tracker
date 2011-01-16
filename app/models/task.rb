class Task < ActiveRecord::Base

  require 'date_extension'
  require 'reporter'
  include ActionView::Helpers::NumberHelper


  belongs_to :project
  belongs_to :estimator
  belongs_to :baseline
  belongs_to :estimation
  belongs_to :ressource

  has_many :estimations, :dependent => :destroy
  has_many :baselines, :dependent => :destroy
  has_many :work_actuals

  validates_presence_of :name
  validates_presence_of :estimation_type
  validates_presence_of :pm_contingency
#  validates_presence_of :start
# validates_presence_of :stop
  validates_presence_of :ressource


  # after_update  :create_works_if_baseline

  #  def create_works_if_baseline
  #    if self.baseline then
  #      Work.create_works_for_baseline(self.baseline)
  #    end
  #  end

  ## helper

  def self.pm_contingency_array
    return ['no contingency', 'normal'],
        ['68% in budget', 'sigma_1'],
        ['95% in budget', 'sigma_2'],
        ['99% in budget', 'sigma_3']
  end

  def get_contingency_factor
    pm_contingency[pm_contingency.size-1].to_i
  end

  def pm_contingency_txt
    Task.pm_contingency_array.each do |line|
      return line[0]+' ('+line[1]+')' if line[1]==pm_contingency
    end
    return 'ERROR - unknown contingency'
  end

  ##### Budget Calculations

  # object: baseline or estimate, type: eac, eac_mean, sigma
  def cost(object, type)

    # if no estimation exists for the task, choose baseline
    object=:baseline if object==:estimation and not self.estimated?

    return 0 if self.send(object).nil?
    type=type.to_s+"_hours" unless (type==:sigma or type==:variance)

    self.ressource.cost*self.send(object).send(type) unless self.send(object).nil?
  end

  def cost_short(object, type)
    return "-" if self.send(object).nil?
    number_with_precision(self.cost(object, type), :precision=>0)
  end


############# Works #####################################################
  def status

    if not self.wait_for_estimation? then
      return "Baseline requested (effort)" if self.latest_baseline_status ==:requested_only_effort or self.latest_baseline_status==:estimated_only_effort
      return "Baseline requested" if self.latest_baseline_status ==:requested

      return "inactiv" if self.start.nil? or self.start > Date.today
      return "open" if self.latest_baseline_status == :open

      return "Baseline: estimated" if self.latest_baseline_status ==:estimated and self.estimation.nil?
    end
    return "Estimation:  #{self.estimations.first.status.to_s}"

  end

  def pending_status?
    self.wait_for_baseline? or self.wait_for_estimation?
  end

  def planned_work_hours
    return '-' if self.estimation.nil? or self.baseline.nil?
    self.baseline.pv
  end

  def current_work_hours
    return '-' if self.estimation.nil? or self.baseline.nil?
    self.estimation.total_actual_hours
  end

  def per_complete
    return '-' if self.estimation.nil? or (not self.estimation.is_estimated?)
    "#{(self.estimation.pert_per_complete*100).round}%"
  end

#    if super()==true thtask.pending_status?en
#      "active"
#    else
#      "inactive"
#    end
#  end

  def estimated_baseline
    self.baseline
  end

  def latest_baseline_status
    return :open if self.latest_baseline.nil?
    return self.latest_baseline.status
  end


  def request_allowed?(request)

    return false if self.ressource.blank?

    case request
      when :estimation
        return false if self.baseline.nil? or self.baseline.status!=:estimated
        return false if not(self.estimation.nil?) and self.estimation.new_work_actuals?
      when :baseline_only_effort

      when :baseline
        return false if self.start.nil?
    end

    return true

  end


  def baseline_requested?
    return false if self.baseline.nil?
    if self.latest_baseline.id==self.baseline.id then
      return false
    else
      return true
    end
  end

  def estimated?
    return false if self.estimation.nil?
    return true
  end

  def latest_baseline
    self.baselines.first
  end

### Used for control display of the info box

  def wait_for_estimation?

    return false if self.estimations[0].nil? or self.estimations.count==0

    return true if (self.estimations.first.status==:requested or self.estimations.first.status ==:requested_only_effort)

    return false

  end

  def wait_for_baseline?

    return false if self.baselines[0].nil? or self.baselines.count==0

    return true if (self.latest_baseline_status==:requested or self.latest_baseline_status ==:requested_only_effort)

    return false


  end

#### Reporting ##########################

  def get_budget_types
    res=Array.new
    self.ressource.budget_types.each do |bt|
      res << bt.id
    end
    return res.sort!
  end


end


