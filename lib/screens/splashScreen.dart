import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
    final breedResponse = await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));
    final breedData = json.decode(breedResponse.body);
    dogBreeds = List<String>.from(breedData['message'].keys);

    await Future.wait(dogBreeds.map((breed) async {
      final imageResponse = await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/images/random'));
      final imageData = json.decode(imageResponse.body);
      breedImages[breed] = imageData['message'];
    }));

    await Future.delayed(const Duration(seconds: 2));

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
        child: Image.asset(
          'assets/logo.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
