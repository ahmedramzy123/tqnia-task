import 'package:tqnia_chat/firebase_options.dart';
import 'package:tqnia_chat/models/notification_manger.dart';
import 'package:tqnia_chat/providers/auth_provider.dart';
import 'package:tqnia_chat/providers/chats_provider.dart';
import 'package:tqnia_chat/ui/screens/auth_screens/login_screen.dart';
import 'package:tqnia_chat/ui/screens/chat_screens/conversations_screen.dart';
import 'package:tqnia_chat/ui/screens/notifications_page.dart';
import 'package:tqnia_chat/ui/screens/splash_screen.dart';
import 'package:tqnia_chat/utils/api.dart';
import 'package:tqnia_chat/utils/cache_helper.dart';
import 'package:tqnia_chat/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/fcm_service_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "chat_task",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DioHelper.init();
  await CacheHelper.init();
  NotificationManger().initNotification();
  await FCMServiceImpl().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _getHomeWidget(AuthProvider auth) {
    return FutureBuilder<bool>(
      future: auth.autoLogin(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }
        return (snapshot.data ?? false)
            ? const ConversationsScreen()
            : const LoginScreen();
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<ChatsProvider>(
          create: (_) => ChatsProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (BuildContext context, AuthProvider auth, Widget? child) =>
            MaterialApp(
          title: 'UChat',
          theme: UChatTheme.getLightTheme(),
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: _getHomeWidget(auth),
        ),
      ),
    );
  }
}
