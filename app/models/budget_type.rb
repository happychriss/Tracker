class BudgetType < ActiveRecord::Base
 belongs_to :budget_group
 has_and_belongs_to_many :Ressources


#def self.groups
#  BudgetType.find(:all, :select => 'group_name' ).map{ |i| i.group_name }.uniq
#
#end


end
