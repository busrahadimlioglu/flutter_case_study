import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.blue[600], size: 40),
      unselectedIconTheme: const IconThemeData(color: Colors.black, size: 40),
      selectedItemColor: Colors.blue[600],
      selectedLabelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
      currentIndex: currentIndex,
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined),
          label: 'Settings',
        ),
      ],
    );
  }
}
