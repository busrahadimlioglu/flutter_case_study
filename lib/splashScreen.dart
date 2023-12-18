import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'homePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<String> dogBreeds = [];
  Map<String, String> breedImages = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Fetch dog breeds
    final breedResponse = await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));
    final breedData = json.decode(breedResponse.body);
    dogBreeds = List<String>.from(breedData['message'].keys);

    // Fetch images for each breed (assuming only the first image for simplicity)
    await Future.wait(dogBreeds.map((breed) async {
      final imageResponse = await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));
      final imageData = json.decode(imageResponse.body);
      breedImages[breed] = imageData['message'];
    }));

    // Wait for a moment before navigating to the main screen (for visual effect)
    await Future.delayed(Duration(seconds: 2));

    // Navigate to the home screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(dogBreeds: dogBreeds, breedImages: breedImages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
