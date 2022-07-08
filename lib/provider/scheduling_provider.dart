import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app2/utils/helper/background/background_service.dart';
import 'package:restaurant_app2/utils/helper/background/schedule_date_time.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      ('Scheduling Reminder Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeSchedule.formatSchedule(),
        exact: true,
        wakeup: true,
      );
    } else {
      ('Scheduling Reminder Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
