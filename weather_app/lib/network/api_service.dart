import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<Map<String, dynamic>> getWeather(String city) async {
    
    final geoUrl =
        'https://geocoding-api.open-meteo.com/v1/search?name=$city&count=1';

    final geoResponse = await http.get(Uri.parse(geoUrl));

    if (geoResponse.statusCode != 200) {
      throw Exception('Failed to get location');
    }

    final geoData = jsonDecode(geoResponse.body);

    if (geoData['results'] == null || geoData['results'].isEmpty) {
      throw Exception('City not found');
    }

    final location = geoData['results'][0];

    final double lat = location['latitude'];
    final double lon = location['longitude'];




    
    final weatherUrl =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,relative_humidity_2m,surface_pressure,wind_speed_10m';

    final weatherResponse = await http.get(Uri.parse(weatherUrl));

    if (weatherResponse.statusCode != 200) {
      throw Exception('Failed to fetch weather');
    }

    final weatherData = jsonDecode(weatherResponse.body);

    return {
      'city': location['name'],
      'temperature': weatherData['current']['temperature_2m'],
      'humidity': weatherData['current']['relative_humidity_2m'],
      'pressure': weatherData['current']['surface_pressure'],
      'wind': weatherData['current']['wind_speed_10m'],
    };
  }
}