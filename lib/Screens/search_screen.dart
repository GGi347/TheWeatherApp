import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:the_weather_app/Services/api_connectivity.dart';
import 'package:the_weather_app/Screens/parent_screen.dart';


import '../const.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  void getPosition(String query) async{
    try{
      List<GBSearchData> data = await GeocoderBuddy.query(query);
      List<GBSearchData> searchItem = [];
      setState(() {

        searchItem = data;
      });
      print(searchItem);
      if(searchItem.isNotEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            ParentScreen(latitude: double.parse(searchItem[0].lat),
                longitude: double.parse(searchItem[0].lon))));
      }
      else{
        isLoading = false;
        _showMyDialog();
      }
      }
    catch(e){
      isLoading = false;
      _showMyDialog();
    }
  }
  final TextEditingController _locationController = TextEditingController();
  ApiConnectivity apiConnectivity = ApiConnectivity();


  Future getLocation() async {
    try {
      Position position = await apiConnectivity.determinePosition();;
      if (position != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ParentScreen(latitude: position.latitude, longitude: position.longitude,)));
      }
      else{
        setState(() {

          //error_msg = "Cannot access Location. Try again later.";
        });
      }
    }catch(e){
      setState(() {

       // error_msg = "Permission Denied To Access User's Location";
      });

    }

  }
  Future<void> _showMyDialog() async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kBackgroundColor,
          title: const Text("Not Found!"),

          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[

                Text("The co-ordinates for the place you entered could not be found."),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 8.0),
        Text(
          "Pick Location",
          style: kHeaderTextStyle,
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Find the area that you want to know the detailed weather info of.",
              textAlign: TextAlign.center,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _locationController,
            decoration: InputDecoration(
              hintText: "Location",
              prefixIcon: Icon(Icons.search),

                border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.name,
            maxLength: 80,
            onSubmitted: (
            String value) async{
              if(value != "" ){
               isLoading = true;
               setState(() {
                 getPosition(value);
               });

                //TODO: get position for the location. use try catch.
                // TODO: call location screen with the position;
                // TODO: else show error
              }
              else{
                setState(() {
                  _showMyDialog();
                });

              }

            },

          ),
        ),
        GestureDetector(
          child: Text("Get Current Location", textAlign: TextAlign.right,style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 16.0
          ),),
          onTap: (){
            isLoading = true;
            setState(() {
              getLocation();
            });

          },
        ),
        isLoading ? SpinKitFadingCircle(
          color: Colors.white,
          size: 60.0,
        ): SizedBox(),
      ],

    );
  }
}


