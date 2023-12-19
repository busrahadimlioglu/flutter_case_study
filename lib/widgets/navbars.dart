import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar bottomNavBar(BuildContext context)
{
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.blue[600], size: 35),
      unselectedIconTheme: const IconThemeData(color: Colors.black, size: 35),
      selectedItemColor: Colors.blue[600],
      selectedLabelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      unselectedLabelStyle: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: IconButton(

            onPressed: (){
              Navigator.pushNamed(context, '/homePage');
            },
            icon: const Icon(Icons.home),
          ),
          label: 'Home',

        ),
        BottomNavigationBarItem(
          icon: IconButton(

            onPressed: (){
              Navigator.pushNamed(context, '/settingsPage');
            },
            icon: const Icon(Icons.settings_outlined),
          ),
          label: 'Settings',

        ),
      ]
  );
}