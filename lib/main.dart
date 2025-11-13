import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/settings_bloc/settings_bloc.dart';
import 'package:weather_app_bloc/bloc/settings_bloc/settings_state.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_event.dart';
import 'package:weather_app_bloc/data/settings_service.dart';
import 'package:weather_app_bloc/data/weather_repository.dart';
import 'package:weather_app_bloc/presentation/weather_page.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => SettingsService()),
        RepositoryProvider(create: (context) => WeatherRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsBloc(context.read<SettingsService>())
              ..add(LoadSettings())
              ..add(LoadSettings()),
          ),
          BlocProvider(
            create: (context) =>
                WeatherBloc(context.read<WeatherRepository>(), context.read<SettingsBloc>())
                  ..add(FetchWeatherForCurrentLocation()),
          ),
        ],

        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(LoadSearchHistory());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final SettingsBloc settingsBloc = context.read<SettingsBloc>();
        final isDarkMode = settingsBloc.state.isDarkMode;
        final themeData = isDarkMode ? ThemeData.dark() : ThemeData.light();
        return MaterialApp(debugShowCheckedModeBanner: false, theme: themeData, home: const WeatherPage());
      },
    );
  }
}
