import 'package:http/http.dart' as http;
import 'package:palbus_app/services/auth_preferences.dart';

class ApiRequester {
  static final api = 'https://palbus.herokuapp.com/';
  // static final api = 'http://localhost:3000/';

  static post(String url, String params) async {
    return await http.post(
      api + url,
      body: params,
      headers: {
        'Authorization': await AuthPreferences.getToken(),
        'Content-type': 'application/json',
        'Accept': 'application/json',
      }
    );
  }

  static get(String url) async {
    return await http.delete(
      api + url,
      headers: {
        'Authorization': await AuthPreferences.getToken(),
      },
    );
  }

  static delete(String url) async {
    return await http.delete(
      api + url,
      headers: {
        'Authorization': await AuthPreferences.getToken(),
      },
    );
  }

  static patch(String url, String params) async {
    return await http.patch(
      api + url,
      body: params,
      headers: {
        'Authorization': await AuthPreferences.getToken(),
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
