// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart'; // Add this for animations
import 'package:weather_app_bloc/bloc/settings_bloc/settings_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_event.dart';
import 'package:weather_app_bloc/bloc/weather_bloc/weather_state.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              child: Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SwitchListTile(
              title: const Text('Use Dark Mode'),
              value: context.select((SettingsBloc bloc) => bloc.state.isDarkMode),
              onChanged: (value) {
                context.read<SettingsBloc>().add(ToggleTheme());
              },
              secondary: const Icon(Icons.brightness_6),
            ),
            SwitchListTile(
              title: const Text('Use Celsius'),
              value: context.select((SettingsBloc bloc) => bloc.state.isCelsius),
              onChanged: (value) {
                context.read<SettingsBloc>().add(ToggleUnit());
              },
              secondary: const Icon(Icons.thermostat),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// === Search Area ===
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cityController,
                    decoration: const InputDecoration(
                      labelText: 'Enter City',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final city = cityController.text.trim();
                    if (city.isNotEmpty) {
                      context.read<WeatherBloc>().add(FetchWeather(city));
                    }
                  },
                  child: const Text("Get"),
                ),
              ],
            ),

            /// === Main Content Area ===
            Expanded(
              child: Center(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherInitial) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 200.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/lottie/weather_sunny.json', width: 150, repeat: true),
                            const SizedBox(height: 16),
                            const Text(
                              "Enter a city to begin",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    } else if (state is WeatherLoading) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/lottie/cat_loading.json', width: 450),
                          const SizedBox(height: 12),
                          const Text("Fetching weather...", style: TextStyle(fontSize: 18)),
                        ],
                      );
                    } else if (state is WeatherLoaded) {
                      final weather = state.weather;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 600),
                            switchInCurve: Curves.easeIn,
                            switchOutCurve: Curves.easeOut,
                            child: Lottie.asset(
                              'assets/lottie/${weather.icon}',
                              key: ValueKey(weather.icon), // unique for each animation
                              width: 200,
                              repeat: true,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(weather.cityName, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(
                            "${weather.temperature.toStringAsFixed(1)}°C",
                            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                          ),
                          const SizedBox(height: 8),
                          Text(weather.description, style: const TextStyle(fontSize: 24)),
                          SizedBox(
                            height: 180,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: weather.dailyForecasts.length,
                              itemBuilder: (context, index) {
                                final day = weather.dailyForecasts[index];

                                // Parse your string date to DateTime
                                // Assuming day.day is like "2025-11-09"
                                final date = DateTime.tryParse(day.day);

                                // If parsing fails, you can fallback to current date
                                if (date == null) {
                                  return const SizedBox();
                                }

                                // Format the date for UI
                                final formattedDay = DateFormat('EEE').format(date); // e.g. Mon
                                final formattedDate = DateFormat('MMM d').format(date); // e.g. Nov 9

                                return Container(
                                  width: 130,
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.shade400.withOpacity(0.9),
                                        Colors.blue.shade200.withOpacity(0.8),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 6,
                                        offset: const Offset(2, 4),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          formattedDay, // Monday, Tuesday, etc.
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          formattedDate, // Nov 9, etc.
                                          style: const TextStyle(fontSize: 12, color: Colors.white70),
                                        ),
                                        const SizedBox(height: 8),

                                        Lottie.asset('assets/lottie/${day.icon}', width: 50, height: 50, repeat: true),

                                        const SizedBox(height: 8),

                                        Text(
                                          "Max: ${day.maxTemp.toStringAsFixed(1)}°C",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Min: ${day.minTemp.toStringAsFixed(1)}°C",
                                          style: const TextStyle(fontSize: 11, color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is WeatherError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/lottie/error_404.json', width: 500),
                          const SizedBox(height: 12),
                        ],
                      );
                    } else if (state is WeatherError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, color: Colors.red, size: 80),
                          const SizedBox(height: 8),
                          Text(state.message, style: const TextStyle(color: Colors.red, fontSize: 18)),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
