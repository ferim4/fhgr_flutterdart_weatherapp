/*
Project for WPFL MAD @FHGR, HS2020
Creators/Authors: Samir Limani, Karin Schori & Florim Rrahmani
Editor used: Visual Studio Code Version: 1.50.1
Tested with: Android Emulator - Pixel 2 API 28 
API used: openweathermap.org
*/
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
//for json needed
import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  //var currently;
  var humidity;
  var windSpeed;
  int temperature;
  String location = 'Zurich';
  int woeid = 784794;
  String weather = "clear";
  String abbreviation = "c";
  String errorMessage = "";

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;

  String searchApiURL =
      "https://www.metaweather.com/api/location/search/?query=";
  String locationApiURL = "https://www.metaweather.com/api/location/";

  //Basically runs anything inside this method first
  @override
  initState() {
    super.initState();
    fetchLocation();
    this.getWeather();
  }

  void fetchSearch(String input) async {
    try {
      var searchResult = await http.get(searchApiURL + input);
      var result = json.decode(searchResult.body)[0];

      setState(() {
        location = result["title"];
        woeid = result["woeid"];
        errorMessage = "";
      });
    } catch (error) {
      setState(() {
        errorMessage =
            "Sorry, there is no data available for the searched location. Try another one.";
      });
    }
  }

  void fetchLocation() async {
    var locationResult = await http.get(locationApiURL + woeid.toString());
    var result = json.decode(locationResult.body);
    var consolidated_weather = result["consolidated_weather"];
    var data = consolidated_weather[0];

    setState(() {
      temperature = data["the_temp"].round();
      weather = data["weather_state_name"].replaceAll(" ", "").toLowerCase();
      abbreviation = data["weather_state_abbr"];
      print(abbreviation);
    });
  }

  void onTextFieldSubmitted(String input) async {
    await fetchSearch(input);
    await fetchLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
      onTextFieldSubmitted(place.locality);
      print(place.locality);
    } catch (e) {
      print(e);
    }
  }
  /*
  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });
  }
  */

  Future getWeather() async {
    http.Response response = await http.get(
        "http://api.openweathermap.org/data/2.5/weather?q=" +
            location +
            "&units=metric&appid=37389495fa8f5248a03c046a9fc6f54e");
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      //this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(abbreviation);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                _getCurrentLocation();
              },
              child: Icon(Icons.location_city, size: 36.0),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 1.0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in " + location.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  //API Call takes a little while, so instead of showing zero degrees celsius, it should show Loading Symbol
                  //16.11.2020 18:38 Florim: this CircularProgressIndicator thing won't work...
                  temperature == null
                      //? Center(child: CircularProgressIndicator())
                      ? "Loading..."
                      : temperature.toString() + "\u00B0",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Image.network(
                    'https://www.metaweather.com/static/img/weather/png/' +
                        abbreviation +
                        '.png',
                    width: 50,
                  ),
                  /*child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),*/
                ),
                Container(
                  width: 200,
                  child: TextField(
                    onSubmitted: (String input) {
                      onTextFieldSubmitted(input);
                    },
                    style: TextStyle(color: Colors.black, fontSize: 25),
                    decoration: InputDecoration(
                      hintText: "Search location...",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 19.0),
                      prefixIcon: Icon(Icons.search, color: Colors.black),
                    ),
                  ),
                ),
                /*FlatButton(
                    onPressed: () {
                      _getCurrentLocation();
                    },
                    color: Colors.green,
                    child: Text("Hit ME!")),
                Text(_locationMessage),*/
                Text(errorMessage,
                    style: TextStyle(color: Colors.redAccent, fontSize: 10))
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(25.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    //If temp is not equal to null, temp then converted to string
                    //Otherwise if temp is equal to null, respectively no data is incoming, only the string "Loading" shows in the app
                    title: Text("Temparature"),
                    trailing: Text(temperature != null
                        ? temp.toString() + "\u00B0"
                        : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null
                        ? description.toString()
                        : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidityture"),
                    trailing: Text(
                        humidity != null ? humidity.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind Speed"),
                    trailing: Text(
                        windSpeed != null ? windSpeed.toString() : "Loading"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
