class CreateBudgetGroups < ActiveRecord::Migration
  def self.up
    create_table :budget_groups do |t|
      t.string :group_name
    end
  end

  def self.down
    drop_table :budget_groups
  end
end
