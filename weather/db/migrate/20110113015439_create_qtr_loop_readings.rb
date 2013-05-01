class CreateQtrLoopReadings < ActiveRecord::Migration
  def self.up
    create_table :qtr_loop_readings do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :qtr_loop_readings
  end
end
