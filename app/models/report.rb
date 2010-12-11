class Report < ActiveRecord::Base
  require 'reporter'
  attr_accessible :name, :pm_id
  belongs_to :project
  has_many :report_lines, :dependent => :destroy, :order => "position"

  accepts_nested_attributes_for :report_lines, :allow_destroy => true

  # iterates over all report lines of a report, only returning active lines with group assigned
#  def each_active_reportline
#    self.report_lines.each { |rl| yield rl unless rl.budget_group_id.nil? }
#  end


  ############# general ################################
  # returns the report line for a specific position
  def report_line_by_position(position)
    self.report_lines.find_by_position(position)
  end

  # returns the types that are related to a position, e.g. for position 0 = KR and GRC
  def get_types_by_position(position)
    res=Array.new
    self.report_line_by_position(position).budget_group.BudgetTypes.each  do |bt|
      res << bt.id
    end
    return res
  end


  ############# view - show available types ################################

  # returns all groups that are assigned to a report - needed to displays groups assigned
  def get_assigned_groups
    res=Array.new
    self.report_lines.each { |rl| res.push(rl.budget_group) unless rl.budget_group.nil?  }
    return res

  end

  # returns all groups that are NOT assigned to a report - needed to displays groups
  def get_not_assigned_groups
    res=Array.new
    assigned_groups=self.get_assigned_groups
    BudgetGroup.all.each do |bg|
      res.push(bg) if assigned_groups.index(bg).nil?
    end
    return res
  end


  #######################  supporting search matrix creation

  # key procedure to return the search array
  def build_search_array
    res=Array.new
    pos=Array.new

    self.report_lines.each do  |rl|
      pos[rl.position-1]=Reporter::Position.new(self, rl.position)

    end

    for i in 0..self.get_total_runs-1
      res[i]=Array.new
      self.report_lines.each do |rl|
        np=pos[rl.position-1].next_position
        res[i][rl.position-1]=np unless np==0
      end
    end

    return res.sort!

  end

  
  # get tasklist prepared to be displayed on report:
  # #<struct Reporter::ResultListItem types=[31], tasks=[14, 15]>, #<struct Reporter::ResultListItem types=[31, 34], tasks=[14, 15]>]
  def get_report_tasks

    task_list=Array.new
    report_types_list=self.build_search_array
    result_list=Array.new
    all_tasks= self.project.tasks.collect {|t| t.id}
    result_list << Reporter::SumTask.new(all_tasks,[]) unless all_tasks.empty?

    self.project.tasks.each do |t|
      task_list << Reporter::TaskListItem.new( t.id, t.get_budget_types)
    end

    report_types_list.each do |report_types|

     selected_tasks=Array.new

      task_list.each do |task_item|

        if (task_item[:type_list].sort & report_types.sort) == report_types.sort then
          selected_tasks << task_item[:task_id]
        end
      end
      puts "***************#{report_types.inspect}**********"
      result_list << Reporter::SumTask.new(selected_tasks,report_types) unless selected_tasks.empty? 
    end

    return result_list

  end

  ##### support for matrix creation

  def get_repeat_for_position(current_position)
    return 1 if current_position == 1
    return get_types_by_position(current_position-1).count*get_repeat_for_position(current_position-1)

  end     

#get number of empty entries
  def get_empty_for_position(current_position)
    return 0 if current_position == 1
    return get_types_by_position(current_position-1).count*get_repeat_for_position(current_position-1) +get_empty_for_position(current_position-1)

  end

# get number of possible combinations
  def get_total_runs
    res=0
    self.report_lines.each do |rl|
      res=res+get_repeat_for_position(rl.position)*get_types_by_position(rl.position).count
    end
    return res
  end




end
