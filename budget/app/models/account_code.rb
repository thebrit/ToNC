class AccountCode < ActiveRecord::Base
  set_table_name "dbo.tblAccountCode"

  def id
    self.ID
  end

end
