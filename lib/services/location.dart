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
import "package:geolocator/geolocator.dart";

//Used the internet for help: https://www.digitalocean.com/community/tutorials/flutter-geolocator-plugin
//and the official flutter pub.dev site https://pub.dev/packages/geolocator/versions/5.3.2+2
class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      latitude = position.latitude;
      longitude = position.longitude;
      print("POSITION $position");
    } catch (e) {
      print(e);
    }
  }
}
