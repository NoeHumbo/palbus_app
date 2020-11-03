import 'dart:convert' as json;

import 'package:palbus_app/services/api_requester.dart';

class PaymentRequester {
  static createPayment({
    String amount,
    String tariffID,
    String busID,
  }) async {
    String params = json.jsonEncode({
      'payment': {
        'amount': amount,
        'quantity': '1',
        'tariff_id': tariffID,
        'bus_id': busID,
      }
    });
    return await ApiRequester.post('/payments', params);
  }

  static getPayments() async {
    return await ApiRequester.get('/payments');
  }

  static getPayment(String id) async {
    return await ApiRequester.get('/payments/$id');
  }
}
