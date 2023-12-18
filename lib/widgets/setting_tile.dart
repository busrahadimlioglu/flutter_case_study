import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/settings.dart';

class SettingTile extends StatelessWidget {
  final Setting setting;
  const SettingTile({
    super.key,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(bottom: 10),
            child: Icon(setting.icon, color: Colors.black),
          ),
          const SizedBox(width: 10),
          Text(
            setting.title,
            style: TextStyle(
              color: Color(0xff212C42),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Icon(
            CupertinoIcons.chevron_forward,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }
}