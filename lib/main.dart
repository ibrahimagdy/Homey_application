import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homey/core/provider/app_provider.dart';
import 'package:homey/core/services/loading_service.dart';
import 'package:homey/core/theme/application_theme.dart';
import 'package:homey/layout/home_layout.dart';
import 'package:homey/pages/about_us_screen/about_us_screen.dart';
import 'package:homey/pages/details_screen/details_screen.dart';
import 'package:homey/pages/login_screen/login_screen.dart';
import 'package:homey/pages/map_screen/map_screen.dart';
import 'package:homey/pages/notifications_screen/notifications_screen.dart';
import 'package:homey/pages/onBoarding_screens/onboarding_screens.dart';
import 'package:homey/pages/register_screen/register_screen.dart';
import 'package:homey/pages/splash_screen/splash_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'core/caching/hive_manger.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Future.wait([
    HiveManager.init(),
  ]).then((_) {
    configLoading();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: OverlaySupport(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (context) => const SplashScreen(),
            OnBoarding.routeName: (context) => const OnBoarding(),
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            HomeLayout.routeName: (context) => const HomeLayout(),
            DetailsScreen.routeName: (context) => const DetailsScreen(),
            MapScreen.routeName: (context) => const MapScreen(),
            AboutUsScreen.routeName: (context) => const AboutUsScreen(),
            NotificationScreen.routeName: (context) =>
                const NotificationScreen(),
          },
          builder: EasyLoading.init(
            builder: BotToastInit(),
          ),
          theme: ApplicationTheme.appTheme,
        ),
      ),
    );
  }
}
