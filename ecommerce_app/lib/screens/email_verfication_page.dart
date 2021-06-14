import 'dart:async';

import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerfication extends StatefulWidget {
  @override
  _EmailVerficationState createState() => _EmailVerficationState();
}

class _EmailVerficationState extends State<EmailVerfication> {
  FirebaseServices _firebaseServices = FirebaseServices();

  User user;
  Timer timer;
  bool isVerified = false;

  @override
  void initState() {
    user = _firebaseServices.getCurrentUser();

    user.sendEmailVerification();
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        checkEmailVerified();
      },
    );
    super.initState();
  }

  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = _firebaseServices.getCurrentUser();
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
          child: Text(
        'An email has been sent to ${user.email}, please verify.',
        style: Constants.regularDark,
        textAlign: TextAlign.center,
      )),
    );
  }
}
