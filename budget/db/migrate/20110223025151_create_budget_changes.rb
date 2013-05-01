class CreateBudgetChanges < ActiveRecord::Migration
  def self.up
    create_table :budget_changes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :budget_changes
  end
end
