class BudgetTransaction < ActiveRecord::Base
#  set_table_name "dbo.tblBudgetTransaction"
  set_table_name "tblbudgettransaction"

  def id
    self.ID
  end

  def budget_level_id
    self.tblBudgetLevelID
  end

  def period_date_id
    self.tblPeriodDateID
  end

end
