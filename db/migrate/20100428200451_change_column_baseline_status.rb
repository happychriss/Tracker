class ChangeColumnBaselineStatus < ActiveRecord::Migration
  def self.up
    change_column :baselines, :state, :string , :limit => 30
  end

  def self.down
    change_column :baselines, :state, :string , :limit => 30
  end
end
