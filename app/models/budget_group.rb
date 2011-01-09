class BudgetGroup < ActiveRecord::Base
#  has_and_belongs_to_many :tasks
  has_many :BudgetTypes
end
