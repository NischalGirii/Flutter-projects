import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:weather_app/search.dart';
import 'package:weather_app/weather.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
      selectedIndex: 2, // Location page
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const Search(),
              ),
            );
            break;

          case 2:
            break; // Already on Location
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