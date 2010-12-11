class AddIsPmToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :is_pm, :boolean,  :default => false, :null => false
  end

  def self.down
    remove_column :users, :is_pm
  end
end
