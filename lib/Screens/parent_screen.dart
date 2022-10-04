import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_weather_app/Screens/full_report_screen.dart';
import 'package:the_weather_app/Screens/loading_screen.dart';
import 'package:the_weather_app/Screens/location_screen.dart';
import 'package:the_weather_app/Screens/search_screen.dart';

import '../Data/hourly_forecast.dart';
import '../Services/api_connectivity.dart';
import '../Services/ui_helper.dart';
import '../const.dart';
class ParentScreen extends StatefulWidget {
  double latitude;
  double longitude;
  ParentScreen({required this.latitude, required this.longitude});

  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int _currentIndex = 0;
  HourlyForecast hourlyForecast = HourlyForecast(requiredTemps: [], formattedHours: [], weathercode: []);
  List<Widget> _selectedTab = [];
  @override
  void initState() {
    super.initState();
    startApp();
   _selectedTab = <Widget>[
    LocationScreen(latitude: widget.latitude, longitude: widget.longitude, hourlyForecast: hourlyForecast),
    FullReportScreen(latitude: widget.latitude, longitude: widget.longitude, hourlyForecast: hourlyForecast),
    SearchScreen(),
    ];
  }

  void startApp() async {
    UIHelper uiHelper = UIHelper();
    ApiConnectivity apiConnectivity = ApiConnectivity();
    //HourlyForecast hourlyForecast = HourlyForecast(requiredTemps: [], formattedHours: [], weathercode: []);

    String responseHourly = await apiConnectivity.getWeatherHourly(latitude: widget.latitude, longitude: widget.longitude);
    setState(() {
      uiHelper.updateHourlyUI(responseHourly, hourlyForecast.requiredTemps, hourlyForecast.formattedHours, hourlyForecast.weathercode);
    });
    print("Hourly forecast is");
    print(hourlyForecast.requiredTemps);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: _selectedTab[_currentIndex],
      ),
      bottomNavigationBar:  BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home),
              label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.file_copy),
              label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search),
              label: ''),
        ],
        backgroundColor: kBackgroundColor,
        selectedItemColor: Colors.amber[800],

      ),
    );
  }
}
