import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:weather_app/location.dart';
import 'package:weather_app/weather.dart';
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Scaffold(
        
      ),


    bottomNavigationBar: GNav(
    selectedIndex: 1, // Search page
    onTabChange: (index) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const Weather(),
            ),
          );
          break;

        case 1:
          break; // Already on Search

        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const Location(),
            ),
          );
          break;
      }
    },
    tabs: const [
      GButton(icon: Icons.home, text: 'Home'),
      GButton(icon: Icons.search, text: 'Search'),
      GButton(icon: Icons.location_on, text: 'Location'),
    ],
  ),
    );
  }
}