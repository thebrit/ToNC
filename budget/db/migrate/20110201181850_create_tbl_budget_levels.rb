class CreateTblBudgetLevels < ActiveRecord::Migration
  def self.up
    create_table :tbl_budget_levels do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :tbl_budget_levels
  end
end
