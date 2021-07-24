import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/email_verfication_page.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  'Error: ${snapshot.error}',
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, streamsnapshot) {
                if (streamsnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                        'Error: ${streamsnapshot.error}',
                      ),
                    ),
                  );
                }

                if (streamsnapshot.connectionState == ConnectionState.active) {
                  User _user = streamsnapshot.data;
                  if (_user == null) {
                    return LoginPage();
                  } else if (_user != null) {
                    if (_user.emailVerified) {
                      return HomePage();
                    } else {
                      return EmailVerfication();
                    }
                  }
                }

                return Scaffold(
                  backgroundColor: Theme.of(context).backgroundColor,
                  body: Center(
                    child: Constants.regularProgressIndicator,
                  ),
                );
              },
            );
          }

          return Scaffold(
            body: Center(
              child: Text(
                'initialization App...',
              ),
            ),
          );
        },
      ),
    );
  }
}
