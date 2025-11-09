import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<String> fetchWeather(String cityName) async {
    try {
      // 1. Get coordinates for the city name
      final geoUrl = Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=1&language=en&format=json',
      );
      final geoResponse = await http.get(geoUrl);

      if (geoResponse.statusCode != 200) {
        throw Exception('Failed to find city');
      }

      final geoData = jsonDecode(geoResponse.body);
      if (geoData['results'] == null || geoData['results'].isEmpty) {
        throw Exception('City not found');
      }

      final lat = geoData['results'][0]['latitude'];
      final lon = geoData['results'][0]['longitude'];
      final foundCityName = geoData['results'][0]['name']; // Get formatted name

      // 2. Get standard weather using those coordinates
      final weatherUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true',
      );
      final weatherResponse = await http.get(weatherUrl);

      if (weatherResponse.statusCode != 200) {
        throw Exception('Failed to get weather data');
      }

      final weatherData = jsonDecode(weatherResponse.body);
      final temp = weatherData['current_weather']['temperature'];

      return "$foundCityName: $temp°C";
    } catch (e) {
      // If anything goes wrong (no internet, bad city name), standard practice is to throw
      // an exception that the BLoC will catch.
      throw Exception('Error fetching standard weather: $e');
    }
  }
}
