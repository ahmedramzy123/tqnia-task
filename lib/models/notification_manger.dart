import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManger
{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
 Future<void> initNotification()async
  {
   
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id,title,body,payload){},

    );
    final LinuxInitializationSettings initializationSettingsLinux =
     LinuxInitializationSettings(
        defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details)
        {

        });
  }
  Future<void> notificationShow({required String title,required String body})async
  {
    AndroidNotificationDetails androidNotificationDetails=
    const AndroidNotificationDetails(
        "channelId",
        "channelName",
      priority: Priority.high,
      importance: Importance.max,
      icon:"ic_launcher" ,
      channelShowBadge: true,
      largeIcon: DrawableResourceAndroidBitmap("ic_launcher")

    );

    NotificationDetails notificationDetails =
    NotificationDetails(android:androidNotificationDetails );
    await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }
}