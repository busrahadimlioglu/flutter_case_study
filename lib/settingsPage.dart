import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_case_study/widgets/navbars.dart';
import 'package:flutter_case_study/widgets/setting_tile.dart';
import 'dart:io';
import 'models/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String osVersion = getOSVersion();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: List.generate(
                    settings.length,
                        (index) => SettingTile(setting: settings[index]),

                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Icon(Icons.cable_outlined, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "OS Version",
                      style: TextStyle(
                        color: Color(0xff212C42),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      osVersion,
                      style: TextStyle(fontSize: 14),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String getOSVersion() {
  if (Platform.isIOS) {
    return 'iOS ${Platform.operatingSystemVersion}';
  } else if (Platform.isAndroid) {
    return 'Android ${Platform.operatingSystemVersion}';
  } else {
    return '';
  }
}