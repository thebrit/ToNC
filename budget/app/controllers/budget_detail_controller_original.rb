class BudgetDetailController < ApplicationController
  
  def index

  end

  def update
    @year = params[:year]
#    @start = 0
#    @end = 9
#    @index = 0  #@start
    if params[:account_select] == 'revenue'
      @accounts = Account.all(:conditions => "AllowsBudget > 0 AND tblAccountCodeID = 5",
                              :order => "FormattedAccountNumber ASC" ) #,
                              #:limit => 10)
    elsif  params[:account_select] == 'expense'
      @accounts = Account.all(:conditions => "AllowsBudget > 0 AND tblAccountCodeID = 2",
                              :order => "FormattedAccountNumber ASC" ) #,
                              #:limit => 10)

    else
      @accounts = Account.all(:conditions => "AllowsBudget > 0",
                              :order => "FormattedAccountNumber ASC" ) #,
                              #:limit => 10)

    end
#    @test = @accounts[@index]
#    sgeg
  end

  def forward
#    #function not required will try and do this in javascript on the client
#    @index = params[:id].to_i + 1
#    @accounts = Account.all(:conditions => "AllowsBudget > 0",
#                            :order => "FormattedAccountNumber ASC",
#                            :limit => 10)
#
#    @test = @accounts[@index]
#
##    sdgr
#    render :partial => 'accountheader'
  end

  def get_budget
#    jggkk
    @tblAccountID = params[:tblAccountID]
    @year = params[:year]
    next_year = (@year.to_i + 1).to_s
    #need the GL account number to get at the budget along with the period date
    #wonder if we can do this in the model?

#    get the year start period - need to go into the model
#    period = PeriodDate.all(:conditions => ["GLPeriod = ?", @year[2..3]])
#    period.each do |x|
#      @start_period_date = x.id
#    end
    start_period = PeriodDate.get_period(@year)
#    get the year last period - need to go into the model
#    period = PeriodDate.all(:conditions => ["GLPeriod = ?", next_year[2..3]])
#    period.each do |x|
#      @end_period_date = x.id
#    end
    end_period = PeriodDate.get_period(next_year)
    glcode = Account.find(@tblAccountID)
#    glcode.each do |x|
    @glcode = glcode.AccountNumber
#    end
#    approved = BudgetTransaction.all(:conditions =>
#                                      ["GLAccount = ? and tblPeriodDateID = ?",
#                                        @glcode, start_period_date])
#    Only deals with BUD1 values
    @approved_budget = BudgetTransaction.sum('Amount', :conditions =>
                                      ["GLAccount = ? AND tblPeriodDateID >= ?
                                        AND tblPeriodDateID < ? AND
                                        tblBudgetLevelID = 1",
                                        @glcode, start_period, end_period])

#    approved.each do |x|
#      @approved_budget = x.Amount
#    end
#    @budgets = Budget.all(:conditions => "tblAccountID = #{params[:tblAccountID]}")
    budgets = MonthlyBudget.all(:conditions => ["tblAccountID = ? and budget_year = ?",
                                          @tblAccountID, @year] )

#                              :order => "FormattedAccountNumber ASC",
#                              :limit => 6)
#    gyuguug
    if budgets.empty?
      @budget = MonthlyBudget.new
      @total = 0.00
      @balance = @approved_budget.to_f.abs - @total
      render :partial => 'budget_new'
    else
      budgets.each do |x|
#        test = x
#        @budget = Budget.find(x.id)
        @budget = MonthlyBudget.find(x.id)
        @total = @budget.january + @budget.february + @budget.march +
                  @budget.april + @budget.may + @budget.june + @budget.july +
                  @budget.august + @budget.september + @budget.october +
                  @budget.november + @budget.december
        @balance = @approved_budget.to_f.abs - @total
        #need previous years numbers too
      end
      render :partial => 'budget_update'
    end

  end

#  def add_budget
    #re-calculate the total
    #should be done with javascript on the client
    #replaced by displayTotal() function in application.js
#    @total = params[:budget][:january].to_f + params[:budget][:february].to_f +
#              params[:budget][:march].to_f + params[:budget][:april].to_f +
#              params[:budget][:may].to_f + params[:budget][:june].to_f +
#              params[:budget][:july].to_f + params[:budget][:august].to_f +
#              params[:budget][:september].to_f + params[:budget][:october].to_f +
#              params[:budget][:november].to_f + params[:budget][:december].to_f
#    render :text => @total.to_s
#  end

end
