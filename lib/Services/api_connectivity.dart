import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:the_weather_app/const.dart';

class ApiConnectivity {
  Future<String> getWeatherForLocation({required double latitude, required double longitude}) async {


      var url = Uri.https("api.openweathermap.org", "/data/2.5/weather", {
        "lat": "${latitude}",
        "lon": "${longitude}",
        "appid": "${getApiKey()}",
        "units": "metric"
      });
      http.Response response = await http.get(url);

      return response.body.toString();
    }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw('Permission Denied');

      }
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
  }


  Future<String> getWeatherHourly({required double latitude, required double longitude}) async {


      //https:///v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m
      try {
        var url = Uri.https("api.open-meteo.com", "/v1/forecast", {
          "latitude": "${latitude}",
          "longitude": "${longitude}",
          "hourly": ["temperature_2m", "weathercode"],

        });
        http.Response response = await http.get(url);
        return response.body.toString();
      } catch (e) {
        return ("Exception is $e");
      }
    }




//https://api.open-meteo.com/v1/forecast?latitude=26&longitude=88&daily=weathercode,temperature_2m_max&timezone=GMT
  Future<String> getDailyForecast({required double latitude, required double longitude}) async {

      //https:///v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m
      try {
        var url = Uri.https("api.open-meteo.com", "/v1/forecast", {
          "latitude": "${latitude}",
          "longitude": "${longitude}",
          "daily": ["temperature_2m_max", "weathercode"],
          "timezone": "GMT",

        });
        http.Response response = await http.get(url);
        print(response.body.toString());
        return response.body.toString();
      } catch (e) {
        return ("Exception is $e");
      }
    }


}
