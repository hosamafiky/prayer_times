import 'dart:developer';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
//If you just want the latest
import 'package:timezone/timezone.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  LocalNotificationService._internal();
  static final LocalNotificationService _instance = LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;

  Future<void> initialize({Function(NotificationResponse)? onNotificationResponseReceived}) async {
    // Initialization setting for android
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    if (Platform.isAndroid) {
      await _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
      await _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
    } else {
      await _notificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            sound: true,
            badge: true,
            alert: true,
            critical: true,
          );
    }
    await _notificationsPlugin.initialize(
      initializationSettings,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: onNotificationResponseReceived,
    );
  }

  Future<void> display(String title, String message) async {
    // To display the notification in device
    try {
      final platform = _getNotificationDetails();
      await _notificationsPlugin.show(DateTime.now().microsecond, title, message, platform);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> schedule({required String title, required String body, required DateTime time}) async {
    log('time : ${DateFormat.jm().format(TZDateTime.from(time, local))}');
    try {
      final platform = _getNotificationDetails();
      await _notificationsPlugin.zonedSchedule(
        DateTime.now().microsecond,
        title,
        body,
        TZDateTime.from(time, local),
        platform,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> removeNotifications() async => await _notificationsPlugin.cancelAll();
  Future<List<ActiveNotification>> getNotifications() async => await _notificationsPlugin.getActiveNotifications();

  NotificationDetails _getNotificationDetails() {
    final android = AndroidNotificationDetails(
      "${DateTime.now()}",
      "Default",
      priority: Priority.high,
      importance: Importance.max,
      playSound: true,
      shortcutId: DateTime.now().toIso8601String(),
    );
    const ios = DarwinNotificationDetails();
    return NotificationDetails(android: android, iOS: ios);
  }

  TZDateTime nextInstanceOfTenAM(DateTime date) {
    TZDateTime now = TZDateTime.now(local);
    TZDateTime convertedDate = TZDateTime.from(date, local);
    TZDateTime scheduledDate = TZDateTime(local, now.year, now.month, now.day, convertedDate.hour, convertedDate.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
