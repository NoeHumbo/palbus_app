import 'dart:async';

import 'package:flutter/material.dart';
import 'package:palbus_app/services/auth_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1000), () async {
      await AuthPreferences.getToken() != null
          ? Navigator.of(context).pushReplacementNamed('/app')
          : Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue[50],
      child: Stack(
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white54,
              radius: 150,
            ),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Image.asset('assets/images/logo-3.png'),
            ),
          ),
        ],
      ),
    );
  }
}
