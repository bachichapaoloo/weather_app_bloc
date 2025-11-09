import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart'; // Add this for animations
import 'package:weather_app_bloc/bloc/weather_bloc.dart';
import 'package:weather_app_bloc/bloc/weather_event.dart';
import 'package:weather_app_bloc/bloc/weather_state.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                        ],
                      );
                    } else if (state is WeatherError) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset('assets/lottie/error_404.json', width: 500),
                          const SizedBox(height: 12),
                          // Text(
                          //   state.message,
                          //   textAlign: TextAlign.center,
                          //   style: const TextStyle(color: Colors.red, fontSize: 18),
                          // ),
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
          ],
        ),
      ),
    );
  }
}
