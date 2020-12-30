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
import "package:weather_app/services/location.dart";
import "package:weather_app/services/network.dart";

const String apiKey = "37389495fa8f5248a03c046a9fc6f54e";
const String openWeatherMapURL =
    "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  //to get used with asynchronous programming, we had to resarch a little deeper than the things we had at the lessons
  //this sources helped us to get used with future, async and await
  //https://dart.dev/codelabs/async-await
  //https://entwickler.de/online/development/async-await-flutter-579937742.html
  //https://medium.com/flutter-community/a-guide-to-using-futures-in-flutter-for-beginners-ebeddfbfb967
  Future<dynamic> getCityWeather(String cityName) async {
    //The url link is getting formed with the input of the string city name and its url plus the api key
    //and here the weather data ist getting prepared to display (searched location)
    var url = "$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric";
    //Networkhelper part is needed to get data from the API, and therefore the http package ist needed
    //have a look at the network.dart file to see what happens
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    //Location is defined in the location.dart file
    Location location = Location();
    await location.getCurrentLocation();

    //this part is needed to get the current location of the device and to get its weather data from the API
    NetworkHelper networkHelper = NetworkHelper("$openWeatherMapURL?"
        "lat=${location.latitude}&lon=${location.longitude}"
        "&appid=$apiKey&units=metric");

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

//if you wonder how and where the id and it's condition can be defined, have a look at https://openweathermap.org/weather-conditions
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return "🌩";
    } else if (condition < 400) {
      return "🌧";
    } else if (condition < 600) {
      return "☔️";
    } else if (condition < 700) {
      return "☃️";
    } else if (condition < 800) {
      return "🌫";
    } else if (condition == 800) {
      return "☀️";
    } else if (condition <= 804) {
      return "☁️";
    } else {
      return '🤷‍';
    }
  }

//simply used emojis in windows with combination: windowsbutton + .
  String getMessage(int temp) {
    if (temp > 25) {
      return "It's 🍦 time";
    } else if (temp > 20) {
      return "Time for shorts and 👕";
    } else if (temp < 10) {
      return "Brrr 🥶 You'll need  🧣 and 🧤";
    } else {
      return "Bring a 🧥 just in case";
    }
  }
}
