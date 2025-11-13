import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _kUnitKey = 'temp_unit';
  static const String _kThemeKey = 'theme_dark_mode';
  static const String _kSearchHistoryKey = 'search_history';

  Future<void> setUnit(bool isCelsius) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kUnitKey, isCelsius);
  }

  Future<bool> getUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kUnitKey) ?? true;
  }

  Future<void> setTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kThemeKey, isDarkMode);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kThemeKey) ?? false;
  }

  Future<void> addCityToHistory(String city) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_kSearchHistoryKey) ?? [];

    // TODO 1: Add logic to manage the list
    // - Remove the city if it already exists (to avoid duplicates)
    history.remove(city);
    // - Add the new city to the *front* of the list (newest first)
    history.add(city);
    // - Make sure the list doesn't grow past 5 items (e.g., `history.take(5).toList()`)
    history.take(5).toList();

    await prefs.setStringList(_kSearchHistoryKey, history);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_kSearchHistoryKey) ?? [];
  }

  Future<void> clearSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kSearchHistoryKey);
  }
}
