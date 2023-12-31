import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Setting {
  final String title;
  final IconData icon;

  Setting({
    required this.title,
    required this.icon,
  });
}

final List<Setting> settings = [
  Setting(
    title: "Help",
    icon: CupertinoIcons.info,
  ),
  Setting(
    title: "Rate Us",
    icon: Icons.star_border_outlined,
  ),
  Setting(
    title: "Share With Friends",
    icon: Icons.share,
  ),
  Setting(
    title: "Terms of Use",
    icon: Icons.file_copy_outlined,
  ),
  Setting(
    title: "Privacy Policy",
    icon: Icons.verified_user_outlined,
  ),

];
