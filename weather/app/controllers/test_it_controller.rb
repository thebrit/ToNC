class TestItController < ApplicationController
#  require 'open_flash_chart'
  def index
    @graph = open_flash_chart_object(600,120,"test_it/graph_code")
  end
  
  def graph_code
    title = Title.new("First Graph")
    bar = Line.new
    bar.set_values([1,2,3,4,5,6,7,8,18,10])
    y_axis = YAxis.new
    y_axis.set_range(0, 20, 2)
    chart = OpenFlashChart.new
    chart.set_title(title)
    chart.add_element(bar)
    chart.y_axis = y_axis

#    render :text => chart.to_s
    render :json => chart
  end

end
