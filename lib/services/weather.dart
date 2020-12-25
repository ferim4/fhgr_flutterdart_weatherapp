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
import "package:weather_app/services/networking.dart";

const String apiKey = "37389495fa8f5248a03c046a9fc6f54e";
const String openWeatherMapURL =
    "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = "$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric";
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

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
