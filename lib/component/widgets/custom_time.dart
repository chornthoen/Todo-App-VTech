import 'package:intl/intl.dart';

class CustomTime {
  static String getFormattedTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd/MMM/yyyy : hh - mm a');
    return formatter.format(dateTime);
  }

  static DateTime parseFormattedTime(String formattedTime) {
    final DateFormat formatter = DateFormat('dd/MMM/yyyy : hh - mm a');
    return formatter.parse(formattedTime);
  }
}
