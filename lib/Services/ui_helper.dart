import 'dart:convert';
import 'date_time_formats.dart';
import 'package:the_weather_app/Data/current_forecast.dart';

class UIHelper{

  void updateUI(String response, CurrentForecast currentForecast) {

      if (response != null) {
        var weather = jsonDecode(response);
        currentForecast.cityName = weather["name"];
        String weatherIcon = weather["weather"][0]["icon"].toString();

        currentForecast.humidity = weather["main"]["humidity"];

        currentForecast.icon = weather["weather"][0]["icon"];
        try{
          currentForecast.temp = weather["main"]["temp"];
          currentForecast.wind = weather["wind"]["speed"];
        }
        catch(e){
          if(e is TypeError){
            currentForecast.temp = weather["main"]["temp"].toDouble();
            currentForecast.wind = weather["wind"]["speed"].toDouble();
          }
          else{
            print(e);
          }
        }
      }

  }

  void updateHourlyUI(String response, var requiredTemps, var formattedHours, var weathercode) async {
    try{
      DateTimeFormats dateTimeFormats = DateTimeFormats();
      var res = jsonDecode(response);
      var hours = res["hourly"]["time"];
      var temps = res["hourly"]["temperature_2m"];
      var imagecode =  res["hourly"]["weathercode"];
      int currHour = dateTimeFormats.getHour();
      for( var i = 0; i <= 23; i++ ) {
        var formattedHour = dateTimeFormats.formatHour(hours[i]);
        if(formattedHour < currHour){
          continue;
        }
        else if(formattedHour > 23){
          break;
        }
        else{
          formattedHours.add(formattedHour);
        }

      }
      for(var i=formattedHours[0]; i <= formattedHours[formattedHours.length -1]; i++){

        requiredTemps.add(temps[i]);

        weathercode.add(imagecode[i].round().toString());
      }
      print(weathercode);

    }catch(e){
      print("exception");
      print(e);
    }
  }

  void updateDailyUI(String response, var dailyTemps, var formattedDates,  var weathercodeDaily, var weekdays) async {
    try{
      DateTimeFormats dateTimeFormats = DateTimeFormats();
      var res = jsonDecode(response);
      var dailyDates = res["daily"]["time"];
      var temps = res["daily"]["temperature_2m_max"];
      var weathercode=  res["daily"]["weathercode"];

      for( var i = 0; i <= 6; i++ ) {
        var formattedDate = dateTimeFormats.getDateTimeWeekly(dailyDates[i]);
        var weekDay = dateTimeFormats.getDateTimeWeekDay(dailyDates[i]);
          formattedDates.add(formattedDate);
          dailyTemps.add(temps[i]);
          weathercodeDaily.add(weathercode[i]);
          weekdays.add(weekDay);
      }

    }catch(e){
      print("exception");
      print(e);
    }
  }

}