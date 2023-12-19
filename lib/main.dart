import 'package:flutter/material.dart';
import 'package:flutter_case_study/screens/homePage.dart';
import 'package:flutter_case_study/screens/settingsPage.dart';
import 'package:flutter_case_study/screens/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/homePage': (context) => const HomePage(dogBreeds: [], breedImages: {}),
        '/settingsPage': (context) => const SettingsPage(),
      },
        home: const SplashScreen(),
    );
  }
}
