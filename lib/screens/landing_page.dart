import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_case_study/homePage.dart';

import '../bloc/landing_page_bloc.dart';

List<BottomNavigationBarItem> bottomNavItems = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: 'Settings',
  ),
];

const List<Widget> bottomNavScreen = <Widget>[
  HomePage(),
  Text('Settings'),
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingPageBloc, LandingPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: bottomNavScreen.elementAt(state.tabIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavItems,
              currentIndex: state.tabIndex,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                BlocProvider.of<LandingPageBloc>(context)
                    .add(TabChange(tabIndex: index));
              },
            ),
          );
        },
    );
  }
}
