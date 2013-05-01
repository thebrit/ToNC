class BudgetLevel < ActiveRecord::Base
  set_table_name "dbo.tblBudgetLevel"

  def id 
    self.ID
  end
end
