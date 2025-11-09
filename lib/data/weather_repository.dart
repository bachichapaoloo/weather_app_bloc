import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherRepository {
  Future<Weather> fetchWeather(String cityName) async {
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
      final foundCityName = geoData['results'][0]['name'];

      // 2. Get current weather
      final weatherUrl = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true',
      );
      final weatherResponse = await http.get(weatherUrl);

      if (weatherResponse.statusCode != 200) {
        throw Exception('Failed to get weather data');
      }

      final weatherData = jsonDecode(weatherResponse.body);
      final current = weatherData['current_weather'];

      final temp = (current['temperature'] as num).toDouble();
      final weatherCode = current['weathercode'] ?? 0;

      // Use a small helper to map weathercode to an icon & description
      final weatherInfo = _mapWeatherCode(weatherCode);

      return Weather(
        cityName: foundCityName,
        temperature: temp,
        description: weatherInfo['description']!,
        icon: weatherInfo['icon']!,
      );
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  Map<String, String> _mapWeatherCode(int code) {
    if (code == 0) {
      // Clear sky
      return {'description': 'Sunny', 'icon': 'weather_sunny.json'};
    } else if ([1, 2, 3].contains(code)) {
      // Partly cloudy
      return {'description': 'Partly Cloudy', 'icon': 'weather_partly_shower.json'};
    } else if ([45, 48].contains(code)) {
      // Fog or mist
      return {'description': 'Misty', 'icon': 'weather_mist.json'};
    } else if ([51, 53, 55, 56, 57, 61, 63, 65, 66, 67].contains(code)) {
      // Drizzle or rain
      return {'description': 'Rainy', 'icon': 'weather_storm.json'};
    } else if ([71, 73, 75, 77].contains(code)) {
      // Snow
      return {'description': 'Snowy', 'icon': 'weather_windy.json'};
    } else if ([95, 96, 99].contains(code)) {
      // Thunderstorm
      return {'description': 'Thunderstorm', 'icon': 'weather_thunder.json'};
    } else {
      // Default fallback
      return {'description': 'Unknown', 'icon': 'weather_partly_shower.json'};
    }
  }
}
