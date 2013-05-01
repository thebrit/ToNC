class CreateBudgetTransactions < ActiveRecord::Migration
  def self.up
    create_table :budget_transactions do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :budget_transactions
  end
end
