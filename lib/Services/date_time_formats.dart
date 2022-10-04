
import 'package:intl/intl.dart';

class DateTimeFormats{
  int formatHour(String hour){
    final DateTime dateTime = DateTime.parse(hour);
    final DateFormat formatter = DateFormat.H();
    return  int.parse(formatter.format(dateTime));
  }

  String getDateTime() {
    final DateTime dateTime = DateTime.now();
    final DateFormat formatter = DateFormat.yMMMMd();
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  String getDateTimeWeekly(String date){
    final DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat.MMMd();
    final String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  String getDateTimeWeekDay(String date){
    final DateTime dateTime = DateTime.parse(date);
    final DateFormat formatter = DateFormat.EEEE();
    final String formattedDay= formatter.format(dateTime);
    return formattedDay;
  }

  int getHour() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat.H();
    final String formattedHour = formatter.format(now);
    return int.parse(formattedHour);
  }

}