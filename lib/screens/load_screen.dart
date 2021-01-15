/*
Project for WPFL MAD @FHGR, HS2020
Creators&Authors: Samir Limani, Karin Schori & Florim Rrahmani
Editor used: Visual Studio Code Version: 1.50.1
Tested with: Android Emulator - Pixel 2 API 28 
API used: openweathermap.org
*/

//************************************************
// Import section for needed modules
//************************************************
import "package:weather_app/screens/location_screen.dart";
import "package:weather_app/services/location.dart";
import "package:weather_app/services/network.dart";
import "package:weather_app/services/weather.dart";
import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

class LoadScreen extends StatefulWidget {
  @override
  _LoadScreenState createState() => _LoadScreenState();
}

//Used the internet for help: https://www.digitalocean.com/community/tutorials/flutter-geolocator-plugin
//and the official flutter pub.dev site https://pub.dev/packages/geolocator/versions/5.3.2+2
class _LoadScreenState extends State<LoadScreen> {
  double latitude;
  double longitude;

//Basically runs anything inside this method first
  @override
  void initState() {
    super.initState();
    getLocation();
  }

//Source: getlocation
  void getLocation() async {
    //gest the current location weather data from the weather.dart file while loading the app/loading screen
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        //In this case a bouncy ball (can be changed to rotatingplain, wave etc) while loading screen appears when the mobile app is starting
        //Source. https://pub.dev/packages/flutter_spinkit
        //Source: https://pub.dev/documentation/flutter_spinkit/latest/flutter_spinkit/SpinKitDoubleBounce-class.html
        child: SpinKitDoubleBounce(color: Colors.red, size: 60.0),
      ),
    );
  }
}
