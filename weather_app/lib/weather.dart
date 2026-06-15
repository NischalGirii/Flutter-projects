import 'package:flutter/material.dart';
import 'package:weather_app/network/api_service.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  final WeatherApi weatherApi = WeatherApi();
  final TextEditingController cityController = TextEditingController();

  Map<String, dynamic>? weatherData;
  bool isLoading = false;

  Future<void> loadWeather() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await weatherApi.getWeather(
        cityController.text.trim(),
      );

      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Weather App"),
      centerTitle: true,
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: cityController,
            decoration: const InputDecoration(
              labelText: "Enter City",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: loadWeather,
            child: const Text("Get Weather"),
          ),

          const SizedBox(height: 20),

          if (isLoading)
            const CircularProgressIndicator(),

          if (weatherData != null)
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      weatherData!['city'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "${weatherData!['temperature']} °C",
                      style: const TextStyle(fontSize: 20),
                    ),

                    Text(
                      "Humidity: ${weatherData!['humidity']}%",
                    ),

                    Text(
                      "Wind: ${weatherData!['wind']} km/h",
                    ),

                    Text(
                      "Pressure: ${weatherData!['pressure']} hPa",
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
}