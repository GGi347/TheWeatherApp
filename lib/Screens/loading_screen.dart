import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:the_weather_app/Services/api_connectivity.dart';
import 'package:the_weather_app/Screens/parent_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  bool isLoading = true;
  String error_msg = '';
  ApiConnectivity apiConnectivity = ApiConnectivity();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  Future getLocation() async {
    try {
      Position position = await apiConnectivity.determinePosition();

      if (position != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParentScreen(latitude: position.latitude, longitude: position.longitude,)));
      }
      else{
        setState(() {
          isLoading = false;
          error_msg = "Cannot access Location. Try again later.";
        });
      }
    }catch(e){
      setState(() {
        isLoading = false;
        error_msg = "Permission Denied To Access User's Location";
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0b1136),
      body: Center(

        child: isLoading ? SpinKitFadingCircle(
          color: Colors.white,
          size: 60.0,


        ) : Text(error_msg),

        ),
      );

  }
}
