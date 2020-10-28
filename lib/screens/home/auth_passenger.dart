import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:palbus_app/services/auth_preferences.dart';
import 'package:palbus_app/services/passenger_preferences.dart';

class AuthPassenger {
  static logIn(context, token, passengerName) {
    AuthPreferences.setToken(token);
    PassengerPreferences.setPassengerName(passengerName);
    Navigator.of(context).pushReplacementNamed('/app');
  }

  static logOut(context) {
    AuthPreferences.cleanToken();
    PassengerPreferences.cleanPassengerName();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (Route<dynamic> route) => false,
        );
      },
    );
  }
}
