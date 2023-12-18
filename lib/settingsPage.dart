import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_case_study/widgets/setting_tile.dart';

import 'models/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

