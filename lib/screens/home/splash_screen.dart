import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2000), _onShowLogin);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onShowLogin() => Navigator.of(context).pushReplacementNamed('/login');

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
