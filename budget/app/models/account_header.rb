class AccountHeader < ActiveRecord::Base
  set_table_name "dbo.tblAccountHeader"

  def id
    self.ID
  end

  def account_code_id
    self.tblAccountCodeID
  end

end
