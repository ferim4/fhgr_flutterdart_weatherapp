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
    //to get used with asynchronous programming, we had to resarch a little deeper than the things we had at the lessons
    //this sources helped us to get used with future, async and await
    //https://dart.dev/codelabs/async-await
    //https://entwickler.de/online/development/async-await-flutter-579937742.html
    //https://medium.com/flutter-community/a-guide-to-using-futures-in-flutter-for-beginners-ebeddfbfb967
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
