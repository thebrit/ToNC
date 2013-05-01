class BudgetChangeController < ApplicationController
  def index
  end

  def new
    @departments = Departments.find(:all)
#    @accounts = ''
#    @accounts_1 = ''
  end

  def new_form
#    hjhkjkhjfh
    @from_reserve = params[:change][:from_reserve]
    @department = Departments.find(params[:change][:department_id])
    #need to change to select the accounts for department expenses
    @accounts = Account.all(:conditions => "AllowsBudget > 0",
                            :order => "FormattedAccountNumber ASC" ) #,

  end

  def approve
    ksbbsfsfb
  end

  def create
#     ksbbsfsfb
    @budget = BudgetChange.new(params[:change])
    if @budget.save
#      skjbhj
      #need to contruct email
      redirect_to :controller => 'finance', :action => 'index'
    else
      #we have a problem
#      render :partial => 'index'
      @department = Departments.find(params[:change][:department_id])
      @accounts = Account.all(:conditions => "AllowsBudget > 0",
                              :order => "FormattedAccountNumber ASC" ) #,
#      @change = params[:change]
#      ksbbsfsfb
      render :action => :new_form
    end
  end

  def from_reserves
    fghjk
    @departments = Departments.find(:all)

    @accounts = Account.all(:conditions => "AllowsBudget > 0",
                            :order => "FormattedAccountNumber ASC" ) #,
                              #:limit => 10)
#    render
  end

  def get_accounts_2
#    fghjk
    @accounts_1 = Account.all(:conditions => "AllowsBudget > 0",
                            :order => "FormattedAccountNumber ASC" ) #,
                              #:limit => 10)
#    render :partial => 'account_list_1'
  end

  def change_reserve
    @departments = Departments.find(:all)
    @accounts = ''
    hjbhbhbhj
#    render :partial => 'form_reserve'
  end
end
