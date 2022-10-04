import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:the_weather_app/Data/forecast_image.dart';
import 'package:the_weather_app/Data/hourly_forecast.dart';
import 'package:the_weather_app/Services/date_time_formats.dart';
import 'package:the_weather_app/Screens/full_report_screen.dart';
import '../Services/weather_summary.dart';
import '../Services/hourly_listview.dart';
import '../Services/api_connectivity.dart';
import '../Services/ui_helper.dart';
import '../Data/current_forecast.dart';
import '../const.dart';

class LocationScreen extends StatefulWidget {
  double latitude;
  double longitude;
  HourlyForecast hourlyForecast;
  LocationScreen({required this.latitude, required this.longitude, required this.hourlyForecast});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  CurrentForecast currentForecast = CurrentForecast(cityName: '', icon: '', temp: 0.0, wind: 0.0, humidity: 0);
  ForecastImage forecastImage = ForecastImage();
 // HourlyForecast hourlyForecast = widget.hourlyForecast;
  @override
 void initState(){
    // TODO: implement initState
    super.initState();
   startApp();
  }

  Future<void> startApp() async{
    UIHelper uiHelper = UIHelper();
    ApiConnectivity apiConnectivity = ApiConnectivity();

    String response = await apiConnectivity.getWeatherForLocation(latitude: widget.latitude, longitude: widget.longitude);
    setState(() {
      uiHelper.updateUI(response, currentForecast);
    });
  }

  @override
  Widget build(BuildContext context) {
    HourlyListview hourlyListview = HourlyListview();
    DateTimeFormats dateTimeFormats = DateTimeFormats();
    return

      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 8.0),
        Text(
          currentForecast.cityName,
          style: kHeaderTextStyle,
        ),
        SizedBox(height: 16.0),
        Text(dateTimeFormats.getDateTime()),
        SizedBox(height: 32.0),

        Expanded(child: Image.asset(forecastImage.getImage(currentForecast.icon)), flex: 2,),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WeatherSummary(
              title: "Temp",
              value: "${currentForecast.temp.round().toString()}°",
            ),
            WeatherSummary(
              title: "Wind",
              value: "${currentForecast.wind.toString()}m/s",
            ),
            WeatherSummary(
                title: "Humidity", value: "${currentForecast.humidity.toString()}%"),
          ],
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Today",
              style: kSubHeadingTextStyle,
            ),
            GestureDetector(
              child: Text('View Full Report', style: TextStyle(
                color: Color(0xFF1c75db),
                fontSize: 16.0,

              ),

              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FullReportScreen(latitude: widget.latitude, longitude: widget.longitude, hourlyForecast: widget.hourlyForecast,)));
              },
            )
          ],
        ),

        hourlyListview.buildTodayTemps(widget.hourlyForecast.requiredTemps, widget.hourlyForecast.formattedHours, widget.hourlyForecast.weathercode),
          SizedBox(height: 20.0,),
      ]


    );
  }


  }



