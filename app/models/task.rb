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

    return "baselining effort" if self.latest_baseline_status == :requested_only_effort or self.latest_baseline_status==:estimated_only_effort
    return "inactiv" if self.start.nil? or self.start > Date.today
    return "open" if self.latest_baseline_status == :open
    return "baselined" if self.estimation.nil?
    return "baselining" if self.baseline_requested?

    return self.estimations.first.status.to_s

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

#    if super()==true then
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

### Used for controll display of the info box

  def wait_for_estimation?

    return false if self.estimations.nil? or self.estimations.count==0

    return true if (self.estimations.first.status==:requested or self.estimations.first.status ==:requested_only_effort)

    return false

  end

def wait_for_baseline?

    return false if self.baselines.nil? or self.baselines.count==0

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


