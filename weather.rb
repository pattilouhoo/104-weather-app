require 'barometer'
 
# GET USER LOCATION & WEATHER
puts "what is your location? zip/postal code or city, state or province."
my_location = gets.chomp
 
# define a method for getting the location's weather 
def get_locations_weather(location)
  Barometer.new(location).measure
end

# get weather for today, highs and lows in Farenheight
weather = get_locations_weather(my_location)

# convert celsius to fahrenheit and get highs and lows in fahrenheit also
celtemp = weather.current.temperature.c
to_fahrenheit = (((9*Float(celtemp))/5) + 32)

today_low_f = weather.today.low.f
today_high_f = weather.today.high.f

# tell user the current temperature:

puts "It's currently #{celtemp} degrees C or #{to_fahrenheit} degrees F in #{my_location}\n"
puts "(Low today is #{today_low_f}F, and high is #{today_high_f}F.)"
########


# FORECASTING
tomorrow = Time.now.strftime('%d').to_i + 1  #sets 'tomorrow' as now + 1 day. '%d' converts Year/Month/Day to day of the month

#do loop to format days from forecast data and display day name, conditions, lows and highs in fahrenheit
 
weather.forecast.each do |forecast| 
  day = forecast.starts_at.day
  
  if day == tomorrow # check to see if the day is today + 1 day (aka "tomorrow") as defined in the tomorrow variable above
    dayName = 'Tomorrow' 
  else
    dayName = forecast.starts_at.strftime('%A') #use strftime ('%A) to format days to their full weekday name capitalized
  end
 
# forecast.icon (for condition like sunny, rainy, snowy, windy), forecast.low and forecast.high are built in to Barometer and are called below. 
  puts dayName + ' is going to be ' + forecast.icon + ' with a low of ' + forecast.low.f.to_s + 'F and a high of ' + forecast.high.f.to_s + 'F.'
end
