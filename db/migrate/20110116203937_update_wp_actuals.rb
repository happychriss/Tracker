class UpdateWpActuals < ActiveRecord::Migration
  def self.up
    WpActual.update_all("status='0'","status='open'")
    WpActual.update_all("status='50'","status='ongoing'")
    WpActual.update_all("status='100'","status='closed'")
    change_table :wp_actuals do |t|
     t.change :status, :integer
    end
  end

  def self.down
    change_table :wp_actuals do |t|
     t.change :status, :string
    end
 WpActual.update_all("status='open'","status='0'")
WpActual.update_all("status='ongoing'","status='50'")
WpActual.update_all("status='closed'","status='100'")
  end
end
