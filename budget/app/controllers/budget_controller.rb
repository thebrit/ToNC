class BudgetController < ApplicationController
  def index
#    @levels = BudgetLevel.find(:all)
#    @pos = PoDetail.find(:all)
#    @accounts = Account.all(:conditions => "AllowsBudget > 0",
#                              :order => "FormattedAccountNumber ASC",
#                              :limit => 10)
    @accounts = Account.all(:conditions => "AllowsBudget > 0",
                              :order => "FormattedAccountNumber ASC",
                              :limit => 10)
  end

  def say_when
    render :text => "<p>The Time is <b>" + DateTime.now.to_s + "</b></p>"
  end

  def add

  end

  def destroy

  end
  
  def add_text
    account_detail = Account.find(params[:id])

#    account_detail.each do |x|
#    for detail in account_detail
    account_number = account_detail.AccountNumber
#    end
    @subaccounts = Account.all(:conditions => "AllowsBudget > 0",
                               :order => "FormattedAccountNumber ASC",
                               :limit => 10)

    @account_transactions = Transaction.all(:conditions => "GLAccount = #{account_number}
                                               AND tblPeriodDateID > 195
                                               AND tblPeriodDateID < 212")
    @sum_transactions = Transaction.sum("Amount", :conditions => "GLAccount = #{account_number}
                                               AND tblPeriodDateID > 195
                                               AND tblPeriodDateID < 212")
  end

end
