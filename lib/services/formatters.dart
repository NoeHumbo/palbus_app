import 'package:intl/intl.dart';

class Formatters {
  static getFormatDate(DateTime date, {String format = "dd-MM-yyyy"}) {
    var formatter = new DateFormat(format, 'es_PE');
    return formatter.format(date);
  } 
}