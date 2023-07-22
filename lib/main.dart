import 'package:chat/ui/create_room/create_room_screen.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/room/room_screen.dart';
import 'package:chat/ui/sign_in/sign_in_screen.dart';
import 'package:chat/ui/sign_up/sign_up_screen.dart';
import 'package:chat/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: SplashScreen.routeName,
      initialRoute: HomeScreen.routeName,
      //initialRoute: RoomScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        SignInScreen.routeName: (_) => SignInScreen(),
        SignUpScreen.routeName: (_) => SignUpScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        CreateRoomScreen.routeName: (_) => CreateRoomScreen(),
        RoomScreen.routeName: (_) => RoomScreen()
      },
    );
  }
}
