Future<String> fetchWeather(String cityName) async {
  await Future.delayed(Duration(seconds: 2));
  return 'Sunny in $cityName';
}
