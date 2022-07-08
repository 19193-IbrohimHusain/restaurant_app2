import 'package:intl/intl.dart';

class DateTimeSchedule {
  static DateTime formatSchedule() {
    final current = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    final todayDate = dateFormat.format(current);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    var format = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(format);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return current.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
