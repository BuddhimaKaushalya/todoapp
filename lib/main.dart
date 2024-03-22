import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/pages/ChooseAction.dart';
import 'package:todoapp/pages/Home.dart';
import 'package:todoapp/pages/landing.dart';
import 'package:todoapp/pages/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/pages/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
      },
    );
  }
}
