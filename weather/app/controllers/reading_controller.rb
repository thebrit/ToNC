class ReadingController < ApplicationController
  def index
    @current_readings = LoopReadings.find(:last)
#    @readings = LoopReadings.find(:all)
    @date = DateTime.now
#    @datetime = DateTime.now
    @dew_point = dew_point(@current_readings.outside_temperature, @current_readings.humidity)
    @wind_chill = wind_chill(@current_readings.outside_temperature, @current_readings.ten_min_average_wind_speed)
    #need to sort heat index calc
#    @heat_index = heat_index(@current_readings.outside_temperature, @current_readings.humidity)
    #
    #calls for graphs
    @temp = open_flash_chart_object(600,150,"reading/temp_graph")
    @bar = open_flash_chart_object(600,150,"reading/bar_graph")
    @wind = open_flash_chart_object(600,150,"reading/wind_graph")
    @solar = open_flash_chart_object(600,150,"reading/solar_graph")

#    @graph = open_flash_chart_object(600,300,"reading/graph_code_radar")

  end

  def temp_graph
    #need to get records for the selected day
    date = DateTime.now - 1
    #get the days conditions
    readings = QtrLoopReadings.find(:all,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])
    max = QtrLoopReadings.maximum(:outside_temperature,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])
    min = QtrLoopReadings.minimum(:outside_temperature,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])
#    hum = QtrLoopReadings.last(:humidity,
#                               :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59' and outside_temperature = #{min}"])
    #set the limits of the Y axis
#    max = max.round.to_i + 5
    ymax = max.round.to_i + (5 - max.modulo(5)).to_i
    ymax_c = convertC(ymax).to_i
#    min = min.round.to_i - 5
#    mindew = dew_point(min, hum.humidity).to_i
#    ymin = mindew  - mindew.modulo(5).to_i
#    ymin = min.round.to_i - min.modulo(5).to_i
#    ymin_c = convertC(ymin).to_i
##    max = max.round.to_i + 5
#    ymax = max + 0.1
##    min = min.round.to_i - 5
#    ymin = min - 0.1

    temp = []
    dew = []
    ymin = min
    #for reading in readings
    readings.each do |x|
      temp << x.outside_temperature
      dew << test = dew_point(x.outside_temperature, x.humidity)
      if test < ymin
        ymin = test
      end
    end
    ymin = ymin  - ymin.modulo(5).to_i
    ymin_c = convertC(ymin).to_i

    title = Title.new("Hourly Temperature Change")   #{min}")

    #temperature
    line_t = Line.new
    line_t.text = "Outside Temperature"
    line_t.width = 1
    line_t.dot_size = 3
    line_t.values = temp
    line_t.colour = '#FF0000'

    #dew point
    line_d = Line.new
    line_d.text = "Dew Point"
    line_d.width = 1
    line_d.dot_size = 3
    line_d.values = dew
    line_d.colour = '#008040'

    y = YAxis.new
    y.set_range(ymin, ymax, 5)
    y.colour = '#FF0000'
#    y.grid_colour('#000000')

    y_right = YAxisRight.new
    y_right.set_range(ymin_c, ymax_c, 2)
    x = XAxis.new
    x.set_range(0, 96, 4)
#    x.set_labels(x_labels)
    x.set_labels(hour_labels)
    x.set_offset(false)


    chart = OpenFlashChart.new
    chart.set_title(title)
    chart.add_element(line_t)
    chart.add_element(line_d)
    chart.set_y_axis(y)
    chart.set_y_axis_right(y_right)
    chart.set_x_axis(x)
    chart.set_bg_colour('#FFFFFF')

#    render :text => chart.to_s
    render :json => chart

  end

  def bar_graph
#    readings = LoopReadings.find(:all)
    date = DateTime.now - 1
    #get the days conditions
    readings = QtrLoopReadings.find(:all,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])
    max = QtrLoopReadings.maximum(:barometer,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])
    min = QtrLoopReadings.minimum(:barometer,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])

    #set the limits of the Y axis
#    max = max.round.to_i + 5
#    ymax = max + (5 - max.modulo(5))
#    min = min.round.to_i - 5
#    ymin = min - min.modulo(5)
#    max = max.round.to_i + 5
    ymax = max + 0.1
    convert = (ymax * 100).to_s
    convert = convert.ljust(4,'0')
    convert = convert[0,3]
    ymax = convert.to_f / 10
#    min = min.round.to_i - 5
    ymin = min - 0.05
    convert = (ymin * 100).to_s
    convert = convert.ljust(4,'0')
    convert = convert[0,3]
    ymin = convert.to_f / 10

    bar = []
    for reading in readings
      bar << reading.barometer
    end
    title = Title.new("Barometric Pressure")
    line = Line.new
    line.text = "Barometer Readings"
    line.width = 1
    line.dot_size = 3
    line.values = bar
    line.colour = '#FF0000'

    x = XAxis.new
    x.set_range(0, 96, 4)
#    x.set_labels(x_labels)
    x.set_labels(hour_labels)
    x.set_offset(false)

    y_axis = YAxis.new
#    y_axis.set_range(29.1, 30.5, 0.1)
    y_axis.set_range(ymin, ymax, 0.1)

    chart = OpenFlashChart.new
    chart.set_title(title)
    chart.add_element(line)
    chart.y_axis = y_axis
    chart.x_axis = x
    chart.set_bg_colour('#FFFFFF')

#    render :text => chart.to_s
    render :json => chart

  end

  def wind_graph

    date = DateTime.now - 1
    #get the days conditions
    readings = QtrLoopReadings.find(:all,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])
    max = QtrLoopReadings.maximum(:wind_speed,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])
    #min will always be zero
    ymax = max.round.to_i + (5 - max.modulo(5)).to_i

    wind = []
    for reading in readings
      wind << reading.wind_speed
    end
    title = Title.new("Wind Speed") #   #{ymax}")
#    line = Line.new
    line = Line.new
    line.text = "Wind Speed"
    line.width = 1
    line.dot_size = 3
    line.values = wind
    line.colour = '#FF0000'

    #scatter
#    scatter = Scatter.new('#8B1D55')  # color, dot size
#    scatter.values = [
#      ScatterValue.new(1,10,20),
#      ScatterValue.new(2,12,20),
#      ScatterValue.new(3,3,20),  # x, y, dot size
#      ScatterValue.new(4,8,20),
#      ScatterValue.new(5,7,20),
#      ScatterValue.new(6,12,20)
#    ]
#    scatter.dot_size = 3
    x = XAxis.new
    x.set_range(0, 96, 4)
#    x.set_labels(x_labels)
    x.set_labels(hour_labels)
    x.set_offset(false)

    y_axis = YAxis.new
#    y_axis.set_range(29.1, 30.5, 0.1)
    y_axis.set_range(0, ymax, 5)

    chart = OpenFlashChart.new
    chart.set_title(title)
    chart.add_element(line)
#    chart.add_element(scatter)
    chart.y_axis = y_axis
    chart.x_axis = x
    chart.set_bg_colour('#FFFFFF')

#    render :text => chart.to_s
    render :json => chart

  end

  def graph_code_radar
    # based on this example - http://teethgrinder.co.uk/open-flash-chart-2/radar-chart-lines.php
#    $chart = new open_flash_chart();
     chart = OpenFlashChart.new
#    $chart->set_title( new title( 'Radar Chart' ) );
     chart.set_title(Title.new('Radar Chart'))
#    $line_1 = new line_hollow();
     line_1 = LineDot.new
#    $line_1->set_values(array(3, 4, 5, 4, 3, 3, 2.5));
     line_1.set_values(Array.new([3, 4, 5, 4, 3, 3, 2.5]))
#    $line_1->set_halo_size( 2 );
     line_1.set_halo_size( 2 )
#    $line_1->set_width( 1 );
     line_1.set_width( 1 )
#    $line_1->set_dot_size( 3 );
     line_1.set_dot_size( 3 )
#    $line_1->set_colour( '#FBB829' );
     line_1.set_colour( '#FBB829' )
#    $line_1->set_tooltip( "Gold<br>#val#" );
     line_1.set_tooltip( "Gold<br>#val#" )
#    $line_1->set_key( 'Mr Gold', 10 );
     line_1.set_key( 'Mr Gold', 10 )

#    $line_2 = new line_dot();
     line_2 = Line.new
#    $line_2->set_values(array(2, 2, 2, 2, 2, 2, 2));
     line_2.set_values(Array.new([2, 2, 2, 2, 2, 2, 2]));
#    $line_2->set_halo_size( 2 );
     line_2.set_halo_size( 2 )
#    $line_2->set_width( 1 );
     line_2.set_width( 1 )
#    $line_2->set_dot_size( 3 );
     line_2.set_dot_size( 3 )
#    $line_2->set_colour( '#8000FF' );
     line_2.set_colour( '#8000FF' )
#    $line_2->set_tooltip( "Purple<br>#val#" );
     line_2.set_tooltip( "Purple<br>#val#" )
#    $line_2->set_key( 'Mr Purple', 10 );
     line_2.set_key( 'Mr Purple', 10 )
#    $line_2->loop();
     line_2.loop() # to close the loop

#// add the area object to the chart:
#    $chart->add_element( $line_1 );
     chart.add_element( line_1 )
#    $chart->add_element( $line_2 );
     chart.add_element( line_2 )
#
#    $r = new radar_axis( 5 );
     r = RadarAxis.new( 5 )

#    $r->set_colour( '#DAD5E0' );
     r.set_colour( '#DAD5E0' )
#    $r->set_grid_colour( '#DAD5E0' );
     r.set_grid_colour( '#DAD5E0' )
#    $labels = new radar_axis_labels( array('Zero','','','Middle','','High') );
     labels = RadarAxisLabels.new(Array.new(['Zero','','','Middle','','High']))
#    $labels->set_colour( '#9F819F' );
     labels.set_colour( '#9F819F' )
#    $r->set_labels( $labels );
     r.set_labels( labels );

#    $spoke_labels = new radar_spoke_labels(array(
#        'Strength',
#        'Smarts',
#        'Sweet<br>Tooth',
#        'Armour',
#        'Max Hit Points',
#        '???',
#        'Looks Like a Monkey') );
    spoke_labels = RadarSpokeLabels.new(Array.new([
        'Strength',
        'Smarts',
        'Sweet<br> Tooth',
        'Armour',
        'Max Hit Points',
        '???',
        'Looks Like a Monkey']))

#    $spoke_labels->set_colour( '#9F819F' );
     spoke_labels.set_colour( '#9F819F' )
#    $r->set_spoke_labels( $spoke_labels );
     r.set_spoke_labels( spoke_labels )
#    $chart->set_radar_axis( $r );
     chart.set_radar_axis( r )
#    $tooltip = new tooltip();
     tooltip = Tooltip.new()
#    $tooltip->set_proximity();
     tooltip.set_proximity()
#    $chart->set_tooltip( $tooltip );
     chart.set_tooltip( tooltip )
#    $chart->set_bg_colour( '#ffffff' );
#     chart.set_bg_colour( '#ffffff' )
#    echo $chart->toPrettyString();
    render :text => chart.to_s
  end

  def solar_graph

    date = DateTime.now - 1
    #get the days conditions
    readings = QtrLoopReadings.find(:all,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])
    max = QtrLoopReadings.maximum(:solar_radiation,
                                  :conditions => ["reading_date > '#{date.strftime("%Y-%m-%d")} 23:59:59'"])
    #min will always be zero
    ymax = max.round.to_i + 50  #(5 - max.modulo(5)).to_i

    solar = []
    for reading in readings
      solar << reading.solar_radiation
    end
    title = Title.new("Solar Radiation") #   #{ymax}")
#    line = Line.new
    line = Line.new
    line.text = "Solar Radiation"
    line.width = 1
    line.dot_size = 3
    line.values = solar
    line.colour = '#FF0000'

    #scatter
#    scatter = Scatter.new('#8B1D55')  # color, dot size
#    scatter.values = [
#      ScatterValue.new(1,10,20),
#      ScatterValue.new(2,12,20),
#      ScatterValue.new(3,3,20),  # x, y, dot size
#      ScatterValue.new(4,8,20),
#      ScatterValue.new(5,7,20),
#      ScatterValue.new(6,12,20)
#    ]
#    scatter.dot_size = 3
    x = XAxis.new
    x.set_range(0, 96, 4)
#    x.set_labels(x_labels)
    x.set_labels(hour_labels)
    x.set_offset(false)

    y_axis = YAxis.new
#    y_axis.set_range(29.1, 30.5, 0.1)
    y_axis.set_range(0, ymax, 100)

    chart = OpenFlashChart.new
    chart.set_title(title)
    chart.add_element(line)
#    chart.add_element(scatter)
    chart.y_axis = y_axis
    chart.x_axis = x
    chart.set_bg_colour('#FFFFFF')

#    render :text => chart.to_s
    render :json => chart

  end
end
