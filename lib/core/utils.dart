import 'package:intl/intl.dart';
import 'package:notes_app1/core/constants.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    return DateFormat(Constants.dateFormat).format(dateTime);
  }
  
  static DateTime parseDate(String dateString) {
    return DateFormat(Constants.dateFormat).parse(dateString);
  }
}