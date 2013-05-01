class CreateHilows < ActiveRecord::Migration
  def self.up
    create_table :hilows do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :hilows
  end
end
