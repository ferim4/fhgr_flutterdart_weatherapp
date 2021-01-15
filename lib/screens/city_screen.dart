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
import "package:flutter/material.dart";
import "package:weather_app/utilities/constants.dart";

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

//basically more or less just scaffold stuff needed in this dart file
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/city_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        //Source SafeArea: https://api.flutter.dev/flutter/widgets/SafeArea-class.html
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    //is needed to navigate back and therefore we used this source:
                    //https://flutter.dev/docs/cookbook/navigation/navigation-basics
                    Navigator.pop(context);
                  },
                  child: Icon(
                    //definition of the icon which here is an arrow like this "<-"
                    Icons.arrow_back,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  //to see what style is used, go to file constants.dart
                  decoration: constant_TextFieldInputDecoration,
                  //here the cityname value is transported
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  "Get Weather",
                  //to see what style is used, go to file constants.dart
                  style: constant_ButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
