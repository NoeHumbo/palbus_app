import 'dart:convert' as json;

import 'package:palbus_app/services/api_requester.dart';

class RechargeRequester {
  static createRecharge({
    String amount,
  }) async {
    String params = json.jsonEncode({
      'recharge': {'amount': amount}
    });
    return await ApiRequester.post('/recharges', params);
  }
}
