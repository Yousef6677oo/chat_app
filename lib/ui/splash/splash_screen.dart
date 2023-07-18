import 'package:flutter/material.dart';

import '../sign_in/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "splash_screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 600)).then((value) {
      Navigator.pushReplacementNamed(context, SignInScreen.routeName);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/splash.png")
        )
      ),
    );
  }
}
