import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  static final String tokenKey = 'auth_token_client';

  static Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(tokenKey);
  }

  static setToken(token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(tokenKey, token);
  }

  static cleanToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(tokenKey, null);
  }
}