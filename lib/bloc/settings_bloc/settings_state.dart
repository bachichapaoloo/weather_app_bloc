import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool isCelsius;
  final bool isDarkMode;

  const SettingsState({required this.isCelsius, required this.isDarkMode});

  // Helper to create a new state by changing only one value
  SettingsState copyWith({bool? isCelsius, bool? isDarkMode}) {
    return SettingsState(isCelsius: isCelsius ?? this.isCelsius, isDarkMode: isDarkMode ?? this.isDarkMode);
  }

  @override
  List<Object> get props => [isCelsius, isDarkMode];
}
