class BudgetDetailController < ApplicationController
  
  def index

  end

  def update
    @year = params[:year]
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
#    sgeg
  end

  def update_record
#    jfhajahj
    @budget = MonthlyBudget.find(params[:budget][:id])
#    jksrhkrh
    if @budget.update_attributes(params[:budget])
      @result = 'Budget Updated'
#      @redirect_to :action => 'index'
        render :partial => 'budget_update'
    else
      @result = 'Budget Updated Failed'
#      redirect_to :action => 'index'
    end
  end

  def new
    @budget = MonthlyBudget.new(params[:budget])
#hkshkhjkh
    if @budget.save
      skjbhj
      render :partial => 'index'
    else
#      render :partial => 'index'
    end
  end

  def get_budget
#    jggkk
    @tblAccountID = params[:tblAccountID]
    @year = params[:year]
    next_year = (@year.to_i + 1).to_s
    @prior_year = (@year.to_i - 1).to_s

    prior_period = PeriodDate.get_period(@prior_year)
    start_period = PeriodDate.get_period(@year)
    end_period = PeriodDate.get_period(next_year)

#   need the GL code fromthe index
    glcode = Account.find(@tblAccountID)
    @glcode = glcode.AccountNumber

    # Only deals with BUD1 values
    @approved_budget = BudgetTransaction.sum('Amount', :conditions =>
                                      ["GLAccount = ? AND tblPeriodDateID >= ?
                                        AND tblPeriodDateID < ? AND
                                        tblBudgetLevelID = 1",
                                        @glcode, start_period, end_period])

    budgets = MonthlyBudget.all(:conditions => ["tblAccountID = ? and budget_year = ?",
                                          @tblAccountID, @year] )
    #got to be a better way of doing the next few rows to get prior_budget
    prior_budgets = MonthlyBudget.all(:conditions => ["tblAccountID = ? and budget_year = ?",
                                          @tblAccountID, @prior_year] )
    prior_budgets.each do |x|
      @prior_budget = MonthlyBudget.find(x.id)
    end
    @prior_budget = 0 if @prior_budget.nil?  #was 0.00

    #now we need the monthly actuals
    @month_actuals = Array.new
    month_start = prior_period + 1
    month_end = start_period - 3
    month_start.upto month_end do |period|
      month_total = Transaction.sum('Amount', :conditions => ["GLAccount = ?
                                      AND tblPeriodDateID = ?", @glcode, period])
      month_total = 0 if month_total.nil? #was0.00
      @month_actuals << month_total.to_i.abs  #was .to_f.abs

    end

#    gyuguug
#    if no existing budget create a new records otherwise edit existing
    if budgets.empty?
      @budget = MonthlyBudget.new
      @total = 0   #0.00
      @balance = @approved_budget.to_f.abs - @total
      @notes = "Initial Budgets Entered - " + DateTime.now.strftime("%m/%d/%Y")
      render :partial => 'budget_new'
    else
      budgets.each do |x|
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


end
