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
import "package:http/http.dart" as http;
//is needed for encoding data like json
//Source: https://api.dart.dev/stable/2.10.4/dart-convert/dart-convert-library.html
import "dart:convert";

//Used the one, which we created at school, but also needed other sources:
//https://medium.com/flutter-community/handling-network-calls-like-a-pro-in-flutter-31bd30c86be1
//https://flutter.dev/docs/cookbook/networking/fetch-data
class NetworkHelper {
  NetworkHelper(this.url);

  final url;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
