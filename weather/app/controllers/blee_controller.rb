#class BleeController < ApplicationController
#  def index
#  end
#
#end
class BleeController < ApplicationController
  # Load ZiYa necessary helpers
  helper Ziya::HtmlHelpers::Charts
  helper Ziya::YamlHelpers::Charts
  require 'ziya'

  def index
  end

  # Callback from the flash movie to get the chart's data
  def load_chart
    # Create a bar chart with 2 series composed of 3 data points each.
    # Chart will be rendered using the default look and feel
    chart = Ziya::Charts::Bar.new
    chart.add( :axis_category_text, %w[2006 2007 2008] )
    chart.add( :series, "Dogs", [10,20,30] )
    chart.add( :series, "Cats", [5,15,25] )
    respond_to do |fmt|
      fmt.xml { render :xml => chart.to_xml }
#      render :text => chart
#      render :xml => chart.to_xml
    end
  end
 end
