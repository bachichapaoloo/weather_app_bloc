// This simulates a network call.
class WeatherRepository {
  // The BLoC will call this function.
  Future<String> fetchWeather(String cityName) async {
    // TODO: 1. Add a delay to simulate network (e.g., await Future.delayed...)

    // TODO: 2. Check if cityName == 'fail'. If yes, throw an Exception("...")

    // TODO: 3. If not 'fail', return a fake temperature string (e.g., "Sunny, 25°C")
    return "Default Weather"; // Temporary return to avoid errors while you setup
  }
}
