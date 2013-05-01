class CreateMonthlyBudgets < ActiveRecord::Migration
  def self.up
    create_table :monthly_budgets do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :monthly_budgets
  end
end
