import 'package:flutter/material.dart';
import 'package:the_weather_app/Data/forecast_image.dart';
import 'date_time_formats.dart';

class HourlyListview {


  Expanded buildTodayTemps(var requiredTemps, var formattedHours, var weathercode) {
    DateTimeFormats dateTimeFormats = DateTimeFormats();
    ForecastImage forecastImage = ForecastImage();
    return Expanded(

      child: ListView.builder
        (

          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          //just set this property
          padding: const EdgeInsets.all(8.0),
          itemCount: formattedHours.length,
          itemBuilder: (BuildContext ctxt, int Index) {
            return Card(
              //color: Color(0xFF111129),

              color: Color(0xFF3281db),
              elevation: 0.6,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: SizedBox(
                height: 30.0,
                width: 160.0,

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Image.asset(forecastImage.getImage(weathercode[Index])
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${formattedHours[Index].toString()}.00",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          requiredTemps[Index].round().toString() + "°",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}