class PeriodDate < ActiveRecord::Base
#  set_table_name "dbo.tblPeriodDate"
  set_table_name "tblperioddate"

  def id
    self.ID
  end

  def self.get_period(year)
    period = PeriodDate.all(:conditions => ["GLPeriod = ?", year[2..3]])
    period.each do |x|
      @period_date = x.id
    end

    return @period_date

  end
end
