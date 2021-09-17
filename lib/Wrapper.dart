import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamyafashion/Screens/GetStartedScreen.dart';
import 'Screens/HomeScreen.dart';


class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: 'assets/images/logo.png',
      nextScreen: FirebaseAuth.instance.currentUser == null
          ? GetStartedScreen()
          : HomeScreen(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
