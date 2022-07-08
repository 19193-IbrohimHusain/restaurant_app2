import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app2/data/model/restaurant.dart';
import 'package:restaurant_app2/utils/helper/navigation/navigation.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  int randomNumber = Random().nextInt(19);

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initializeNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initSettingAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initSettingIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initSettings = InitializationSettings(
        android: initSettingAndroid, iOS: initSettingIOS);

    await flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        ('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantList restaurants) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "Restaurant App";
    Restaurant restaurant = restaurants.restaurants[randomNumber];

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Some of the best restaurant in the area</b>";
    var titleReminder = restaurant.name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleReminder, platformChannelSpecifics,
        payload: json.encode(restaurant.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var dataRestaurant = Restaurant.fromJson(json.decode(payload));
        State.intentWithData(route, dataRestaurant);
      },
    );
  }
}
