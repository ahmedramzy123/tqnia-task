import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tqnia_chat/models/notification_manger.dart';
import 'package:tqnia_chat/models/user_model.dart';
import 'package:tqnia_chat/utils/cache_helper.dart';

class FCMServiceImpl {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  @override
  Future<void> init() async {
    await _fcm.requestPermission();
    getDeviceToken();
    onMessageReceived();
    onMessageOpenApp();
   onBackgroundMessageReceived();
  }

// Get deviceToken
  void getDeviceToken() async {
   final deviceToken = await _fcm.getToken();
   CacheHelper.put(key: "token", value: deviceToken);
   print("Device Token : $deviceToken ll");
  }

// App is open
  void onMessageReceived() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      NotificationManger().notificationShow(title: "New Message",
          body:event.notification!.body! );
      print("message recieved");
      print(event.notification!.body);
      print(event.data);
    });
  }


  //  openApp
  void onMessageOpenApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      NotificationManger().notificationShow(title: "New Message"!,
          body: event.notification!.body!);
      print("message openApp");
      print(event.notification!.body);
      print(event.data);
    });
  }

// Message clicked
//   void onMessageTapped() {
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print('Message clicked!');
//       // when Clike the Message Navigat to  =>
//     });
//   }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    NotificationManger().notificationShow(title:"New Message",
        body: message.notification!.body! );
    print("Handling a background message: ${message.data}");
  }

// BackgroundMessage
  Future<void> onBackgroundMessageReceived() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

  }
}
