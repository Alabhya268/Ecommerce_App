import 'package:flutter/material.dart';

class Constants {
  static String title = 'Ecommerce app';

  static TextStyle regularHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle smallRegularHeading = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle boldHeading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle regularDark = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle homeProductCardPrice = TextStyle(
    fontSize: 16,
    color: Color(0xFFFF1E00),
    fontWeight: FontWeight.w600,
  );

  static TextStyle cartProductCardPrice = TextStyle(
    fontSize: 16,
    color: Color(0xFFFF1E00),
    fontWeight: FontWeight.w600,
  );

  static TextStyle cartProductCardSize = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static CircularProgressIndicator regularProgressIndicator =
      CircularProgressIndicator(
    backgroundColor: Colors.white,
    color: Color(0xFFFF1E00),
  );

  static BoxShadow boxShadow = BoxShadow(
    color: Colors.black,
    blurRadius: 2.0,
    spreadRadius: 0.0,
    offset: Offset(2.0, 2.0),
  );

  static Color btnColor = Color(0xFF1D1D1D);
}
