import 'package:flutter/material.dart';
import 'package:palbus_app/screens/home/home_screen.dart';
import 'package:palbus_app/screens/others/maps_screen.dart';
import 'package:palbus_app/screens/others/settings_screen.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: _callPage(currentIndex),
        bottomNavigationBar: Container(
          height: 80,
          child: buildButtomNavigationBar(),
        ),
      ),
    );
  }

  Widget _callPage(int actualPage) {
    switch (actualPage) {
      case 0:
        return MapsScreen();
      case 1:
        return HomeScreen();
      case 2:
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }

  BottomNavigationBar buildButtomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Color.fromARGB(255, 14, 114, 220),
      unselectedItemColor: Colors.white60,
      selectedIconTheme: IconThemeData(
        size: 55,
        color: Colors.white,
      ),
      iconSize: 40,
      onTap: (index) {
        setState(() => currentIndex = index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_bus),
          title: Padding(padding: EdgeInsets.all(0)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Padding(padding: EdgeInsets.all(0)),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Padding(padding: EdgeInsets.all(0)),
        )
      ],
    );
  }
}
