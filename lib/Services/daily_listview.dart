import 'package:flutter/material.dart';
import 'package:the_weather_app/Data/forecast_image.dart';
import 'date_time_formats.dart';

class DailyListview {
  Expanded buildTWeeklyTemps(var dailyTemps, var formattedDates, var weathercodeDaily, var weekdays) {
    DateTimeFormats dateTimeFormats = DateTimeFormats();
    ForecastImage forecastImage = ForecastImage();
    return Expanded(
flex: 3,
      child:
      ListView.builder
        (

          scrollDirection: Axis.vertical,
                    //just set this property
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          itemCount: formattedDates.length,
          itemBuilder: (BuildContext ctxt, int Index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Card(
                //color: Color(0xFF111129),

                color: Color(0xFF3281db),
                elevation: 0.6,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: SizedBox(
                  height: 80.0,
                  width: 120.0,

                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(width: 10.0),


                      Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${weekdays[Index]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(formattedDates[Index] ,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,

                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(dailyTemps[Index].round().toString()+ "°", style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(

                          child: Image.asset(forecastImage.getImage(weathercodeDaily[Index].round().toString())
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}