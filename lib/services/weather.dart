import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';

const apiKey = "26593a2662426b5795c3ee38d4c98f97";
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  late double longitude;
  late double latitude;

  Future<dynamic> getCityWeatherData(String city) async {
    NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapURL?q=$city&appid=$apiKey&units=metric',
    );

    return await networkHelper.getData();
  }

  Future<dynamic> getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();

    longitude = location.longitude;
    latitude = location.latitude;

    NetworkHelper networkHelper = NetworkHelper(
      '$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric',
    );

    return await networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
