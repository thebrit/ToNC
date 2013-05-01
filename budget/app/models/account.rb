class Account < ActiveRecord::Base
#  establish_connection "#{RAILS_ENV}_second"
#  set_table_name "dbo.tblAccount"
  set_table_name "tblaccounts"

  def id 
    self.ID
  end

  def account_code_id
    self.tblAccountCodeID
  end

  def select_code
    "#{self.FormattedAccountNumber} - #{self.Title}"
  end

end
