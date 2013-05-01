class Transaction < ActiveRecord::Base
#    set_table_name "dbo.tblTransaction"
    set_table_name "tbltransaction"

  def id 
    self.ID
  end

  def period_date_id
    #not sure what this is for!!!!!!!!!
    self.tblPeriodDateID
  end

end
