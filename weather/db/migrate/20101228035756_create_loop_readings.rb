class CreateLoopReadings < ActiveRecord::Migration
  def self.up
    create_table :loop_readings do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :loop_readings
  end
end
