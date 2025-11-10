import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/settings_bloc/settings_state.dart';
import 'package:weather_app_bloc/data/settings_service.dart';

part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService settingsService;

  SettingsBloc(this.settingsService) : super(const SettingsState(isCelsius: true, isDarkMode: false)) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleUnit>(_onToggleUnit);
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    final isCelsius = await settingsService.getUnit();
    final isDarkMode = await settingsService.getTheme();
    emit(state.copyWith(isCelsius: isCelsius, isDarkMode: isDarkMode));
  }

  Future<void> _onToggleUnit(ToggleUnit event, Emitter<SettingsState> emit) async {
    final newUnit = !state.isCelsius;
    await settingsService.setUnit(newUnit);
    emit(state.copyWith(isCelsius: newUnit));
  }

  Future<void> _onToggleTheme(ToggleTheme event, Emitter<SettingsState> emit) async {
    final newTheme = !state.isDarkMode;
    await settingsService.setTheme(newTheme);
    emit(state.copyWith(isDarkMode: newTheme));
  }
}
