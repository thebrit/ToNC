module ReadingHelper
  def check_wind(speed)
    if speed == 0
      return "Calm"
    else
      return speed.to_s + " mph"
    end
  end
end
