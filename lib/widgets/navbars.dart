import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar bottomNavBar(BuildContext context)
{
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.blue),
      unselectedIconTheme: IconThemeData(color: Colors.black),
      selectedLabelStyle: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w600),
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