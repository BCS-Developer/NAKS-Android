import 'dart:async';

import 'package:flutter/material.dart';
import 'package:top_examer/ui/login_page/login_page.dart';
import 'package:top_examer/utils/constants.dart';
import 'package:top_examer/utils/shared_preference_utils.dart';
import 'package:top_examer/utils/themes.dart';

import '../home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulating a delay for demonstration purposes
    Timer(const Duration(seconds: 4), () async {
      // Navigate to the login page after the delay
      var userId =
          await SharedPreferenceUtils.getStringFromSp(AppConstants.USER_ID);
      if (userId != null) {
        // if user already login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        //if user not logged in
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.white_color,
      body: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Image.asset(
            'assets/logo.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
