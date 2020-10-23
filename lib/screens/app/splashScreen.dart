  
import 'dart:async';

import 'package:palbus_app/screens/home/login_screen.dart';
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
    _timer = Timer(const Duration(seconds: 20), _onShowLogin);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onShowLogin() {
    if(mounted){
      Navigator.of(context).pushReplacement(LoginScreen.route());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlue[50],
      child: Stack(
        children:[
          Center(
            child: CircleAvatar(

              backgroundColor: Colors.white54,
              radius: 150,
            ),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Image.asset('assets/logo-3.png'),
            ),
          ),
        ],
      ),
    );
  }
}