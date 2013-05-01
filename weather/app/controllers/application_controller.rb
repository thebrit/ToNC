# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  #weather calculations
#  @today = DateTime.now.strftime("%B %d, %Y")
  def dew_point(temp, rh)
    #calcullate the dew point teperature in F from Davis document
    v = rh.to_f * 0.01 * 6.112 * Math.exp((17.62 * convertC(temp)) / (convertC(temp) + 243.12))
    num = 243.12 * Math.log(v) - 440.1
    den = 19.43 - Math.log(v)
    return convertf(num / den).round
  end

  def wind_chill(temp, wind_speed)
    #calculate the wind chill from Davis document
    #based on temperature and 10 min average wind speed
    temp = temp.to_f
    if wind_speed.to_i > 0 and temp < 93.2
      speed = wind_speed.to_f ** 0.16
      wind_chill = 36.74 + (0.6216 * temp) - (35.75 * speed) + ((0.4275 * temp) * speed)
      if wind_chill > temp
        wind_chill = temp
      end
    else
      wind_chill = temp
    end
    return wind_chill.round
#    return wind_chill.floor
  end

  def heat_index(temp, rh)

#    temp = 92
#    rh = 60
#    heat_index = -42.379 + (2.04901523 * temp.to_f) + (10.14333127 * rh.to_f)
#                 +(-0.22475541 * temp.to_f * rh.to_f) + ((-6.83783 * (10 ** -3)) * (temp.to_f * temp.to_f))
#                 +((-5.481717 * (10 ** - 2)) * (rh.to_f * rh.to_f)) + ((1.22874 * (10 ** -3)) * (temp.to_f * temp.to_f) * rh.to_f)
#                 + ((8.5282 * (10 ** - 4)) * temp.to_f * (rh.to_f * rh.to_f)) + ((-1.99 * (10 ** - 6)) * (temp.to_f * temp.to_f) * (rh.to_f * rh.to_f) )
#    heat_index = 8.5282 * (10 ** - 4)
    c1 = -42.379
    c2 = 2.04901523
    c3 = 10.14333127
    c4 = -0.22475541
    c5 = -0.00683783
    c6 = -0.05481717
    c7 = 0.00122874
    c8 = 0.00085282
    c9 = -0.00000199
    heat_index = c1 + (c2 * temp.to_f) + (c3 * rh.to_f) + (c4 * temp.to_f * rh.to_f)
                    + (c5 * temp.to_f * temp.to_f) + (c6 * rh.to_f * rh.to_f)
                    + (c7 * temp.to_f * temp.to_f * rh.to_f)
                    + (c8 * temp.to_f * rh.to_f * rh.to_f)
                    + (c9 * temp.to_f * temp.to_f * rh.to_f * rh.to_f)


  end

  def convertf(temp)
    #take C temp and coverts to F
    return (9.0 / 5.0 * temp) +32.0
  end

  def convertC(temp)
    #take F temp and coverts to C
    return (temp - 32.0) * 5.0 /9.0
  end

  def hour_labels
    #setup the x-axis labels
    x_labels = ['0','','','','1','','','','2','','','','3','','','','4','','','','5',
                  '','','','6','','','','7','','','','8','','','','9','','','','10',
                  '','','','11','','','', 'Noon','','','','1','','','','2','','','','3',
                  '','','','4','','','','5','','','','6','','','','7','','','','8',
                  '','','','9','','','','10','','','','11','','','','12']
  end
end
