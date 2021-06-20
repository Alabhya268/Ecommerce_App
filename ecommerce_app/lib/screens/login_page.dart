import 'package:ecommerce_app/screens/register_page.dart';
import 'package:ecommerce_app/screens/reset_password_page.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_btn.dart';
import 'package:ecommerce_app/widgets/custom_input.dart';
import 'package:ecommerce_app/widgets/password_visibility_checkbox.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseServices _firebaseServices = new FirebaseServices();

  bool _passwordVisibility = false;

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Error',
          ),
          content: Container(
            child: Text(
              error,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });

    String _createAccountFeedback = await _firebaseServices.signInAccount(
        email: _registerEmail, password: _registerPassword);
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
    }
    setState(() {
      _registerFormLoading = false;
    });
  }

  bool _registerFormLoading = false;

  String _registerEmail = null;
  String _registerPassword = null;

  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Welcome User,\nLogin to your account',
              textAlign: TextAlign.center,
              style: Constants.boldHeading,
            ),
          ),
          Column(
            children: [
              CustomInput(
                textInputType: TextInputType.emailAddress,
                hintText: 'Email...',
                onChanged: (value) {
                  _registerEmail = value;
                },
                onFieldSubmitted: (value) {
                  _passwordFocusNode.requestFocus();
                },
                textInputAction: TextInputAction.next,
              ),
              CustomInput(
                isPasswordFeild: !_passwordVisibility,
                hintText: 'Password...',
                onChanged: (value) {
                  _registerPassword = value;
                },
                focusNode: _passwordFocusNode,
                onFieldSubmitted: (value) {
                  _submitForm();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PasswordVisibilityCheckBox((value) {
                    setState(
                      () {
                        _passwordVisibility = value;
                      },
                    );
                  }, _passwordVisibility),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ResetPassword();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Forget Password ?',
                        style: Constants.homeProductCardPrice,
                      ),
                    ),
                  ),
                ],
              ),
              CustomBtn(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                text: 'Login',
                onPressed: () {
                  _submitForm();
                },
                isLoading: _registerFormLoading,
              ),
            ],
          ),
          CustomBtn(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            outlineBtn: true,
            text: 'Create New Account',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RegisterPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
