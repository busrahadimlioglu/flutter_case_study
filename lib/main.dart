import 'package:flutter/material.dart';
import 'package:flutter_case_study/routes/homepage.dart';
import 'package:flutter_case_study/routes/settingspage.dart';

void main() {

  runApp(MaterialApp(
    initialRoute: '/homepage',
    routes: {
      '/settingspage': (context) => Settingspage(),
      '/homepage': (context) => Homepage(),
    },

  ));
}
