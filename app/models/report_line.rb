class ReportLine < ActiveRecord::Base
belongs_to :report
belongs_to :budget_group
acts_as_list :scope => :report




end

