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
import "package:weather_app/screens/city_screen.dart";
import "package:weather_app/services/weather.dart";
import "package:flutter/material.dart";
import "package:weather_app/utilities/constants.dart";

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //section for declaration of the variables
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherbackground;
  String weatherIcon;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    //this function is needed to refresh the displayed data on the screen
    updateScreen(widget.locationWeather);
  }

//this section is needed to get the weather information from API openweathermap.org
  void updateScreen(dynamic weatherData) {
    setState(() {
      //if there is no data(null) it shows this messages like for the weather Icon "Error"
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = "Error";
        weatherMessage = "Couldn't get weather data.";
        weatherbackground = "";
        cityName = "";
        return;
      }
      //here hopefully data is available and shows the temperature etc.
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      weatherbackground =
          weatherData['weather'][0]['main'].replaceAll(' ', '').toLowerCase();
      int condition = weatherData['weather'][0]['id'];
      //this icon is coming from the weather.dart file
      weatherIcon = weather.getWeatherIcon(condition);
      //this message also comes from the weather.dart file
      weatherMessage = weather.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            //got this phenomenal idea to change also backgroundimage in dependency of the weatherstate like snow, thunderstorm, heavyrain etc:
            //Sources: https://github.com/mercihohmann/flutter-weather-app-starterkit/tree/master/weather_app & https://www.youtube.com/watch?v=KKvZrBbaao0
            //use the weather condition page to see what backgrounds are all needed: https://openweathermap.org/weather-conditions
            image:
                AssetImage("images/weatherbackground/$weatherbackground.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                //got the blendmode to fade images from source: https://api.flutter.dev/flutter/dart-ui/BlendMode-class.html
                Colors.white.withOpacity(0.8),
                BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        //Safe Area Class is needed to be sure, that everything is shown inside the screen frame an nothing overlapps outside the screen
        //Source: https://suragch.medium.com/a-visual-guide-to-flutters-safearea-widget-30f5dbdc01d6
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                //This is the area where you can edit the icons position on the top of the screen, so that they not are "glued" nearby
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateScreen(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateScreen(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              //Here you can adjust the position on the screen of temperature and it's weather condition icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$temperature\u00B0",
                    //to see what style is used, go to file constants.dart
                    style: constant_TemperatureTextStyle,
                  ),
                  Text(
                    "$weatherIcon",
                    //to see what style is used, go to file constants.dart
                    style: constant_ConditionTextStyle,
                  ),
                ],
              ),
              //Here you can adjust the position on the screen of the text with the clothes suggestions
              Padding(
                padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                child: Text(
                  //A simple query bellow: if the searched city is unknown or not found, the weathermessage variable shows couldnt get weather data in xxx
                  //all declarde in function void updateScreen on top of this file
                  widget.locationWeather == null
                      ? "$weatherMessage"
                      : "$weatherMessage in $cityName",
                  textAlign: TextAlign.center,
                  //to see what style is used, go to file constants.dart
                  style: constant_MessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
