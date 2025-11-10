part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ToggleUnit extends SettingsEvent {}

class ToggleTheme extends SettingsEvent {}