module BudgetDetailHelper
  def prior_year(prior_budget, month)
    if prior_budget == 0    #was 0.00
      return prior_budget
    else
      return number_with_precision(prior_budget[month].to_i, :precision => 0, :delimiter => ",")
    end

  end
end
