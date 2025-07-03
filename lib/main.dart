import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/dialer_screen.dart';
import 'screens/recents_screen.dart';
import 'screens/contacts_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(const PhoneDialerApp());
}

class PhoneDialerApp extends StatelessWidget {
  const PhoneDialerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Phone Dialer',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.systemBlue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: CupertinoColors.systemBackground,
      ),
      home: const MainTabView(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainTabView extends StatelessWidget {
  const MainTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.systemBackground.withOpacity(0.9),
        activeColor: CupertinoColors.systemBlue,
        inactiveColor: CupertinoColors.systemGrey,
        border: const Border(
          top: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.star),
            activeIcon: Icon(CupertinoIcons.star_fill),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            activeIcon: Icon(CupertinoIcons.clock_fill),
            label: 'Recents',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_crop_circle),
            activeIcon: Icon(CupertinoIcons.person_crop_circle_fill),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.circle_grid_3x3),
            activeIcon: Icon(CupertinoIcons.circle_grid_3x3_fill),
            label: 'Keypad',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const FavoritesScreen();
          case 1:
            return const RecentsScreen();
          case 2:
            return const ContactsScreen();
          case 3:
            return const DialerScreen();
          default:
            return const DialerScreen();
        }
      },
    );
  }
}

