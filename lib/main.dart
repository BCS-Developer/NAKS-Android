// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_examer/providers/banners_provider.dart';
import 'package:top_examer/providers/categories_provider.dart';
import 'package:top_examer/providers/global_provider.dart';
import 'package:top_examer/providers/posts_provider.dart';
import 'package:top_examer/providers/profile_provider.dart';
import 'package:top_examer/providers/send_otp_provider.dart';
import 'package:top_examer/providers/verify_otp_provider.dart';
import 'package:top_examer/ui/TokenManager.dart';
import 'package:top_examer/ui/home_page/home_page.dart';
import 'package:top_examer/ui/login_page/otp_page.dart';
import 'package:top_examer/ui/login_page/splash_screen.dart';
import 'package:top_examer/ui/profile_page/profile_screen.dart';
import 'package:top_examer/utils/constants.dart';
import 'package:top_examer/utils/helper.dart';
import 'package:top_examer/utils/notification_services.dart';
import 'package:top_examer/utils/shared_preference_utils.dart';
import 'package:top_examer/utils/themes.dart';

import 'firebase_options.dart';

late SharedPreferences sharedPreferences;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    sharedPreferences = await SharedPreferences.getInstance();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  } catch (e) {
    print("Failed to initialize Firebase: $e");
  }
  initializeApp();
  runApp(const MyApp());
}
void initializeApp() {
  TokenManager.setTenetId(AppConstants.tenetID);
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();

  /*DP start*/
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  /*DP end*/
  _MyAppState({Key? key});
  /*DP start*/
  @override
  void initState() {
    super.initState();

    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value) async {
      print("fcm token : " + value);
      Provider.of<GlobalProvider>(context, listen: false).setFcmToken(value);
      /*  var userId =
          await SharedPreferenceUtils.getStringFromSp(AppConstants.USER_ID);
      new FcmProvider().updateFcmToken(value, userID);
      if (kDebugMode) {
        print('device token');
        print(value);
      }*/
    });

    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();
    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialLinkString();
    if (appLink != null) {
      print('getInitialAppLink: $appLink');
      openAppLink();
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) async {
      List<String> parts = uri.toString().split('/');
      var data = parts.last;
      // Convert from base64 and Decrypt
      String decryptedBase64Text = fromBase64(data);
      String decryptedText =
          xorEncryptDecrypt(decryptedBase64Text, AppConstants.ENCRYPTION_KEY);
      if (decryptedText != null) {
        await SharedPreferenceUtils.saveStringToSP(AppConstants.POST_ID,
            jsonDecode(decryptedText)[AppConstants.POST_ID].toString());
        await SharedPreferenceUtils.saveStringToSP(AppConstants.CATEGORY_ID,
            jsonDecode(decryptedText)[AppConstants.CATEGORY_ID].toString());
        await SharedPreferenceUtils.saveBoolToSP(
            AppConstants.IS_APPLINK_NAVIGATED, true);
      }
      openAppLink();
    });
  }

  void openAppLink() {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
          builder: (context) => const HomePage(
                initialIndex: 1,
              )),
    );
  }
  /*DP end*/

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalProvider()),
        ChangeNotifierProvider(create: (context) => PostsProvider()),
        ChangeNotifierProvider(create: (_) => BannersProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => SendOTPProvider()),
        ChangeNotifierProvider(create: (context) => VerifyOTPProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey, // Assign navigatorKey to MaterialApp
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfileScreen(),
          '/otp_page': (context) => const VerifyOTPPage(),
        },
        title: AppConstants.appName,
        themeMode: ThemeMode.system,
        theme: Themes.lightThemeData,
        darkTheme: Themes.darkThemeData,
      ),
    );
  }
}
