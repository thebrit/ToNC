class PoDetail < ActiveRecord::Base
  establish_connection "#{RAILS_ENV}_second"
  set_table_name "dbo.tblPODetail"
end
