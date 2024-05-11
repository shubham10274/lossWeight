import 'package:flutter/material.dart';
import 'package:lossy/screens/auth_screen/auth_screen.dart';
import 'package:lossy/screens/home_screen/home_screen.dart';
import 'package:lossy/screens/login_screen/login_screen.dart';
import 'package:lossy/screens/splash_screen/component/body.dart';
import 'package:lossy/screens/start_screen/start_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weight Track',
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => SplashScreen(), // Splash screen route
            '/startup': (context) => StartScreen(), // Start up screen route
            '/signup': (context) => SignUp(), // SignUpScreen route
            '/login': (context) => LoginScreen(), // LoginScreen route
            '/home': (context) => HomeScreen(), // HomeScreen route
          },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: HomeScreen());
    });
  }
}
