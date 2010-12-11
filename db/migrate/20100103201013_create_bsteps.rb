class Createwps < ActiveRecord::Migration
  def self.up
    create_table :wps do |t|
      t.integer :baseline_id
      t.integer :p_estimate
      t.integer :m_estimate
      t.integer :o_estimate
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :wps
  end
end
