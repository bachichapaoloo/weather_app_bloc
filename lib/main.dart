import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_bloc/bloc/settings_bloc/settings_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app_bloc/data/settings_service.dart';
import 'package:weather_app_bloc/data/weather_repository.dart';
import 'package:weather_app_bloc/presentation/weather_page.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => WeatherRepository()),
        RepositoryProvider(create: (context) => SettingsService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => WeatherBloc(context.read<WeatherRepository>())),
          BlocProvider(create: (context) => SettingsBloc(context.read<SettingsService>())),
        ],

        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const WeatherPage());
  }
}
