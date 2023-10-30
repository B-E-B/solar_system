import 'package:flutter/material.dart';
import 'package:solar_system/screens/new_planet_screen.dart';
import 'package:solar_system/screens/solar_system_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/solar_system',
      routes: {
        '/solar_system': (context) => const SolarSystemScreen(),
        '/new_planet': (context) =>  NewPlanetScreen(),
      },
    );
  }
}
