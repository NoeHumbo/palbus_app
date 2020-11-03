import 'dart:convert' as json;

import 'package:palbus_app/services/api_requester.dart';


class AuthRequester {
  static login(email, password) async {
    String params = json.jsonEncode({
      'email': email,
      'password': password,
    });

    return await ApiRequester.post(
      '/authenticate_passenger',
      params,
    );
  }

  static signUp({
    String name,
    String email,
    String dni,
    String mobileNumber,
    String password,
    String passwordConfirmation,
  }) async {
    String params = json.jsonEncode({
      'passenger': {
        'name': name,
        'dni': dni,
        'email': email,
        'mobile_number': mobileNumber,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'balance_attributes': {}
      }
    });
    return await ApiRequester.post(
      '/passengers',
      params,
    );
  }

  static logout() async {
    return await ApiRequester.get('/logout_passenger');
  }

  static destroyPassenger() async {
    return await ApiRequester.delete('/passenger_destroy');
  }

  static passenger() async {
    return await ApiRequester.get('/passenger_show');
  }
}