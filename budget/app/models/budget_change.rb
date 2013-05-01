class BudgetChange < ActiveRecord::Base

  validates_confirmation_of :requester_email,
                            :message => "Email Address missmatch",
                            :on => :create
#  need validations and Account ID's'

  def getAccountID(account_number)
#    id = 

  end
end
