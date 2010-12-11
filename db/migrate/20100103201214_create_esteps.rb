class Createwp_actuals < ActiveRecord::Migration
  def self.up
    create_table :wp_actuals do |t|
      t.integer :wp_id
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :wp_actuals
  end
end
