import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_btn.dart';
import 'package:ecommerce_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _email;
  bool isEmailExist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Password assistance',
              textAlign: TextAlign.center,
              style: Constants.boldHeading,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              'Enter email associated with ${Constants.title}',
              textAlign: TextAlign.center,
              style: Constants.regularDark,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          CustomInput(
            hintText: 'Email...',
            onChanged: (value) {
              _email = value;
            },
          ),
          CustomBtn(
            text: 'Continue',
            onPressed: () async {
              await _firebaseServices.emailExist(_email)
                  ? isEmailExist = true
                  : isEmailExist = false;
              if (isEmailExist) {
                ScaffoldMessenger.maybeOf(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'An email has been sent to your email please continue there.',
                    ),
                  ),
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.maybeOf(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'This email is not registered, Please try again with different email',
                    ),
                  ),
                );
              }
            },
          ),
          CustomBtn(
            text: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
