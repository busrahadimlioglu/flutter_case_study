import 'package:flutter/material.dart';
import 'package:flutter_case_study/widgets/setting_tile.dart';
import 'dart:io';
import '../models/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String osVersion = getOSVersion();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8,70,8,0),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (index < settings.length) {
              return SettingTile(setting: settings[index]);
            } else {
              return Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: const Icon(Icons.cable_outlined, color: Colors.black),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    "OS Version",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    osVersion,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff838282),
                    ),
                  ),
                ],
              );
            }
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(); // Add a Divider between tiles
          },
          itemCount: settings.length + 1, // Add 1 for the additional widgets after the tiles
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
