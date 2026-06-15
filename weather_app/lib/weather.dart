import 'package:flutter/material.dart';
import 'package:weather_app/network/api_service.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


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
        

          const SizedBox(height: 20),
          Center(child: Text("Press search icon for weather info")),
           if (isLoading)
                          const CircularProgressIndicator(),

          if (weatherData != null)
          
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text("Todays Weather"),
                        SizedBox(height: 80,),
                        Image.network(
                          width: 200, height: 200,
                          'https://cdn-icons-png.flaticon.com/512/869/869869.png',
                        ),
                       
                        SizedBox(height: 30,),
                         if (isLoading)
                          const CircularProgressIndicator(),
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
              ),
            ),
         
        ],
      ),
    ),



    
    bottomNavigationBar: GNav(

      
      onTabChange: (index) {
        switch (index) {
          case 0:
             
            break; 

          case 1:
           showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Enter City"),
                      content: TextField(
                        controller: cityController,
                        decoration: InputDecoration(
                          hintText: "Enter City for Weather Info",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            loadWeather();
                            Navigator.pop(context);
                          },
                          child: const Text("Get Weather"),
                        ),
                      ],
                    );
                  },
                );

            
        }
      },
      tabs: const [
        GButton(
          icon: Icons.home,
          text: 'Home',
        ),
        GButton(
          icon: Icons.search,
          text: 'Search',
        ),
        // GButton(
        //   icon: Icons.location_on,
        //   text: 'Location',
        // ),
      ],
    ),
    
  );

}
}