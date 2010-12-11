class Ressource < ActiveRecord::Base


has_many :tasks
belongs_to :project


has_and_belongs_to_many :budget_types, :class_name =>'BudgetType'
accepts_nested_attributes_for :budget_types

validates_presence_of :name
validates_presence_of :cost
validates_numericality_of :cost, :greater_than => 0

before_destroy :check_tasks

def estimation_type_txt
ESTIMATION_TYPE_SHOW[estimation_type]
end

private
  def check_tasks
    raise "Resource can not be deleted, if still assigned to a task" if self.tasks.count!=0  
  end

end
