import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:the_weather_app/Services/daily_listview.dart';
import 'package:the_weather_app/Services/date_time_formats.dart';
import 'package:the_weather_app/const.dart';
import '../Data/hourly_forecast.dart';
import '../Services/hourly_listview.dart';
import '../Services/api_connectivity.dart';
import '../Services/ui_helper.dart';


class FullReportScreen extends StatefulWidget {
  double latitude;
  double longitude;
  HourlyForecast hourlyForecast;
  FullReportScreen({required this.latitude, required this.longitude, required this.hourlyForecast});

  @override
  State<FullReportScreen> createState() => _FullReportScreenState();

}


class _FullReportScreenState extends State<FullReportScreen> {
  var dailyTemps = [];
  var formattedDates = [];
  var weathercodeDaily = [];
  var weekdays = [];
  bool isLoading = true;
  void initState(){
    // TODO: implement initState
    super.initState();

    showFullReport();

  }


  Future<void> showFullReport() async{
    UIHelper uiHelper = UIHelper();
    ApiConnectivity apiConnectivity = ApiConnectivity();
    String responseDaily = await apiConnectivity.getDailyForecast(latitude: widget.latitude, longitude: widget.longitude);
    setState(() {

      uiHelper.updateDailyUI(responseDaily, dailyTemps, formattedDates, weathercodeDaily, weekdays);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    HourlyListview hourlyListview = HourlyListview();
    DailyListview dailyListview = DailyListview();
    DateTimeFormats dateTimeFormats = DateTimeFormats();
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.0,
            ),
            Text(
              "Forecast Report",
              style: kHeaderTextStyle,
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Today",
                  style: kSubHeadingTextStyle,
                ),
                SizedBox(height: 24.0),
                Text(dateTimeFormats.getDateTime()),
              ],
            ),
            hourlyListview.buildTodayTemps(widget.hourlyForecast.requiredTemps, widget.hourlyForecast.formattedHours, widget.hourlyForecast.weathercode),
SizedBox(height: 32.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Next Forecast",
                  style: kSubHeadingTextStyle,
                ),
                Icon(Icons.calendar_month_rounded),
              ],
            ),
            isLoading ? Expanded(
              flex: 3,
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 60.0,
              ),
            ): dailyListview.buildTWeeklyTemps(dailyTemps, formattedDates, weathercodeDaily, weekdays)
          ],
        ),
      ),
    );
  }
}
