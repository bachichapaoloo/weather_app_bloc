import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _kUnitKey = 'temp_unit';
  static const String _kThemeKey = 'theme_dark_mode';

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
}
