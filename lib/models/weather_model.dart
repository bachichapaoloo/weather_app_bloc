class DailyForecast {
  final String day; // e.g., "Monday"
  final double maxTemp;
  final double minTemp;
  final String icon;

  DailyForecast({required this.day, required this.maxTemp, required this.minTemp, required this.icon});
}

class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  // TODO 1: Add a list of DailyForecasts to this main model
  final List<DailyForecast> dailyForecasts;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.dailyForecasts,
  });
}
