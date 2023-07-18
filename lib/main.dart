import 'package:chat/ui/sign_in/sign_in_screen.dart';
import 'package:chat/ui/sign_up/sign_up_sceen.dart';
import 'package:chat/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_)=> SplashScreen(),
        SignInScreen.routeName: (_)=> SignInScreen(),
        SignUpScreen.routeName: (_)=> SignUpScreen()
      },
    );
  }
}
