class CreatePeriodDates < ActiveRecord::Migration
  def self.up
    create_table :period_dates do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :period_dates
  end
end
