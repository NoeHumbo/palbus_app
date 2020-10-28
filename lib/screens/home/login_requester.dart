import 'dart:convert' as json;

import 'package:palbus_app/services/api_requester.dart';


class LoginRequester {
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
    String clientID,
    String email,
    bool isOrganization,
    String mobileNumber,
    String name,
    String password,
    String passwordConfirmation,
  }) async {
    String params = json.jsonEncode({
      'client': {
        'client_id': clientID,
        'email': email,
        'is_organization': isOrganization,
        'mobile_number': mobileNumber,
        'name': name,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }
    });
    print(params);
    return await ApiRequester.post(
      '/security/sign_up',
      params,
    );
  }

  static clientIdConnected() async {
    return await ApiRequester.get('/security/client_id_connected');
  }
}