import 'package:intl/intl.dart';

class Formatters {
  static getFormatDate(DateTime date, {String format = "dd-MM-yyyy"}) {
    var formatter = new DateFormat(format, 'es_PE');
    return formatter.format(date);
  }

  static getFormatNumber(double number) {
    var formatter = new NumberFormat.currency(decimalDigits: 2, symbol: 'S/ ', locale: 'EN');
    return formatter.format(number);
  }
}