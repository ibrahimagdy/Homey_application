import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homey/pages/onBoarding_screens/onboarding_screens.dart';

import '../../layout/home_layout.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      checkLoggedInUser();
    });
    super.initState();
  }

  Future<void> checkLoggedInUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    } else {
      Navigator.pushReplacementNamed(context, OnBoarding.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/splash_screen.png",
            width: mediaQuery.width,
            height: mediaQuery.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: Text(
              "Homey",
              style: theme.textTheme.titleLarge,
            ),
          )
        ],
      ),
    );
  }
}
