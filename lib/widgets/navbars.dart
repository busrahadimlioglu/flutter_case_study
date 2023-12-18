import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BottomNavigationBar bottomNavBar(BuildContext context)
{
  return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
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
            icon: const Icon(Icons.settings),
          ),
          label: 'Settings',

        ),
      ]
  );
}