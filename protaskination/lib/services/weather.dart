import 'location.dart';
import 'networking.dart';

const apiKey = 'd9a0db96c3305510ac6100758b8d89a2';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';
const forecastWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/forecast';

//http://api.openweathermap.org/data/2.5/weather?q=london&appid=d9a0db96c3305510ac6100758b8d89a2
class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapUrl?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = new NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = new NetworkHelper(
        '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherdata = await networkHelper.getData();
    return weatherdata;
  }

  Future<dynamic> getForecastWeather(String cityName) async {
    NetworkHelper networkHelper = new NetworkHelper(
        '$forecastWeatherMapUrl?q=$cityName&appid=d9a0db96c3305510ac6100758b8d89a2&units=metric');
    var forecastweatherdata = await networkHelper.getData();
    return forecastweatherdata;
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
