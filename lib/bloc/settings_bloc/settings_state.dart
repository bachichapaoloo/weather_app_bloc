import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool isCelsius;
  final bool isDarkMode;
  final List<String> searchHistory;

  const SettingsState({required this.isCelsius, required this.isDarkMode, this.searchHistory = const []});

  // Helper to create a new state by changing only one value
  SettingsState copyWith({bool? isCelsius, bool? isDarkMode, List<String>? searchHistory}) {
    return SettingsState(
      isCelsius: isCelsius ?? this.isCelsius,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      searchHistory: searchHistory ?? this.searchHistory,
    );
  }

  @override
  List<Object> get props => [isCelsius, isDarkMode, searchHistory];
}
