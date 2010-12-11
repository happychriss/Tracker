class WorkActual < ActiveRecord::Base
  belongs_to :task
  belongs_to :estimation 
end
