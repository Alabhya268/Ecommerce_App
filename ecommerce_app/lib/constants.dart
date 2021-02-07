import 'dart:ui';

import 'package:flutter/material.dart';

class Constants {
  static TextStyle regularHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle boldHeading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle regularDarkText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static BoxShadow boxShadow = BoxShadow(
    color: Colors.black,
    blurRadius: 2.0,
    spreadRadius: 0.0,
    offset: Offset(2.0, 2.0),
  );

  static Color btnColor = Color(0xFF1D1D1D);
}
