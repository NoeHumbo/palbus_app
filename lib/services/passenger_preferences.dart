import 'package:shared_preferences/shared_preferences.dart';

class PassengerPreferences {
  static final String passengerNameKey = 'passenger_name';

  static Future<String> getPassengerName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(passengerNameKey);
  }

  static setPassengerName(passengerName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(passengerNameKey, passengerName);
  }

  static cleanPassengerName() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(passengerNameKey, null);
  }
}
