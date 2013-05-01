class CreateBudgetLevels < ActiveRecord::Migration
  def self.up
    create_table :budget_levels do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :budget_levels
  end
end
