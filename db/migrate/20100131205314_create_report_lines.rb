class CreateReportLines < ActiveRecord::Migration
  def self.up
    create_table :report_lines do |t|
      t.integer :report_id
      t.integer :budget_type_id
      t.integer :position
    end
  end

  def self.down
    drop_table :report_lines
  end
end
