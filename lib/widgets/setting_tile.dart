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
          const SizedBox(width: 15),
          Text(
            setting.title,
            style: const TextStyle(
              color: Color(0xff000000),
              fontSize: 20,
              fontWeight: FontWeight.w500,
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