import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lossy/screens/start_screen/start_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => StartScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 500,
              height: 500,
              child: Image.asset('assets/images/logo.webp')),
          const SizedBox(
            height: 30,
          ),
        ],
      )),
    ));
  }
}
