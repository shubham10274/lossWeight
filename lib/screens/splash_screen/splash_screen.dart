import 'package:flutter/material.dart';
import 'package:lossy/size_config/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SplashScreen(),
    );
  }
}
