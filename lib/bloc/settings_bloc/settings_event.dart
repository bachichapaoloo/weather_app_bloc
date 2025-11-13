part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ToggleUnit extends SettingsEvent {}

class ToggleTheme extends SettingsEvent {}

class LoadSearchHistory extends SettingsEvent {}

class AddCityToHistory extends SettingsEvent {
  final String city;
  const AddCityToHistory(this.city);

  @override
  List<Object> get props => [city];
}

class ClearSearchHistory extends SettingsEvent {}
