class BaseRequest < ActiveRecord::Base
  set_table_name "estimations"


  include AASM
  aasm_column :state
  aasm_initial_state :new

  aasm_state :new
  aasm_state :new_only_effort

  aasm_state :requested_only_effort, :enter => :implement_requested_status
  aasm_state :requested, :enter => :implement_requested_status

  aasm_state :estimating_step1
  aasm_state :estimating_step2

  aasm_state :estimated, :enter => :implement_estimated_status
  aasm_state :estimated_only_effort, :enter => :implement_estimated_status

  aasm_state :closed , :enter => :implement_closed_status
  aasm_state :final , :enter => :implement_closed_status  
  aasm_state :pm_estimated

  aasm_event :request do
    transitions :to => :requested, :from => [:new ]
    transitions :to => :requested_only_effort, :from => [:new_only_effort ]
  end

  aasm_event :request_only_effort do
    transitions :to => :new_only_effort, :from => [:new, :new_only_effort ]
  end

  aasm_event :estimate do
    transitions :to => :estimated, :from => [:requested, :estimated]
    transitions :to => :estimated_only_effort, :from => [:requested_only_effort, :estimated_only_effort]

  end

  aasm_event :next_step do
    transitions :to => :estimating_step2, :from => [:requested, :estimated]
    transitions :to => :estimating_step2, :from => [:estimating_step1]
    transitions :to => :estimated, :from => [:estimating_step2]
  end

  aasm_event :previous_step do
    transitions :to => :estimating_step1, :from => [:estimating_step2]
  end


  aasm_event :close do
    transitions :to => :closed, :from => [:estimating, :requested, :requested_only_effort, :new, :new_only_effort]
    transitions :to => :final, :from => [:estimated, :estimated_only_effort]
    transitions :to => :final, :from => [:final]
    transitions :to => :closed, :from => [:closed]
  end

  def is_estimated?
    return false if self.estimation_date.nil?
    return true
  end

  ##################### Data from Database
  def sigma
    Math.sqrt(self.variance)
  end

  def eac_mean_hours
    self.eac_hours-(3*self.sigma)
  end

  def contingency
     return 0 if eac_hours==0
     return  ((eac_hours*100)/eac_mean_hours).to_i-100
  end
  
  ##################### Calculation for lists of estimations via tasks

  def self.total_cost(object, task_list)

    sum_var=0

    sum_eac_mean =0

    task_list.each do  |task_id|
      task=Task.find(task_id)

      sum_eac_mean+=task.cost(object, :eac_mean)

      sigma=task.cost(object, :sigma).to_f
      sum_var+=sigma**2
    end

    res=Hash.new
    res[:eac_mean]=sum_eac_mean

    res[:sigma]=Math.sqrt(sum_var)

    res[:eac]=(sum_eac_mean+res[:sigma]*3).to_f.round

    res[:contingency] = ((res[:eac]*100)/res[:eac_mean]).to_i-100

    return res

  end



  # def eac_hours

  ##################################################

  def self.get_sorted_request_list (baselines, estimations)
    (baselines+estimations).sort {|x, y| y.created_at <=> x.created_at}
  end

  def status
    self.aasm_current_state
  end

  def status_txt
    tmp_status=self.status
    tmp_status = :'completed' if self.status==:final
    if self.is_current? then
      tmp_status="#{tmp_status} (current)"
   end
   return tmp_status
  end



# finds a corresponding work from baseline to estimataion and vice versa
  def self.corresponding_work (work_array, in_work_start_date)

    out_work = work_array.select do |bw|
      bw.start_date == in_work_start_date
    end

    out_work[0] unless out_work.nil?

  end

  

end