import 'package:palbus_app/services/api_requester.dart';

class BalanceRequester {
  static balance() async {
    return await ApiRequester.get('/balances');
  }
}