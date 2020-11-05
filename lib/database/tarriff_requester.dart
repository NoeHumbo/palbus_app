import 'package:palbus_app/services/api_requester.dart';

class TariffRequester {
  static tariff() async {
    return await ApiRequester.get('/tariffs');
  }
}