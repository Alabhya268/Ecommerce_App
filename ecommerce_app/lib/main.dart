import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

import 'screens/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.title,
      theme: ThemeData(
        backgroundColor: Color(0xFF121212),
        accentColor: Color(0xFFFF1E00),
        fontFamily: 'Montserrat',
      ),
      home: LandingPage(),
    );
  }
}
