import 'dart:isolate';
import 'dart:ui';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/utils/helper/notification/notification.dart';
import 'package:restaurant_app2/main.dart';

final ReceivePort receivePort = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static const String _isolateName = 'isolate';
  static SendPort? _sendPort;

  BackgroundService._internal() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(receivePort.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    ('Alarm Started');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().listRestaurant();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send(null);
  }
}
