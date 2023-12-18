import 'package:flutter/material.dart';
import 'package:flutter_case_study/homePage.dart';
import 'package:flutter_case_study/routes/generatedRoutes.dart';
import 'package:flutter_case_study/settingsPage.dart';
import 'package:flutter_case_study/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/homePage': (context) => HomePage(dogBreeds: [], breedImages: {}),
        '/settingsPage': (context) => SettingsPage(),
      },
        home: SplashScreen(),
    );
  }
}
