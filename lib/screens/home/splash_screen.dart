import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:palbus_app/services/auth_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  bool _connectionStatus = false;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();

    _timer = Timer(
      const Duration(milliseconds: 1000),
      () async {
        initConnectivity().then((_) async {
          if (_connectionStatus) {
            await AuthPreferences.getToken() != null
                ? Navigator.of(context).pushReplacementNamed('/app')
                : Navigator.of(context).pushReplacementNamed('/login');
          } else {
            notInternetConnection();
          }
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return Future.value(null);
    }

    return await _checkConnection(result);
  }

  Future<void> _checkConnection(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = true);
        break;
      default:
        setState(() => _connectionStatus = false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: Stack(
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

  notInternetConnection() {
    print('NO HAY CONEXION A INTERNET');
  }
}
