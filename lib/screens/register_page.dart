import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:ecommerce_app/widgets/custom_btn.dart';
import 'package:ecommerce_app/widgets/custom_input.dart';
import 'package:ecommerce_app/widgets/password_visibility_checkbox.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

    String _createAccountFeedback = await _firebaseServices.createAccount(
      name: _registerName,
      email: _registerEmail,
      password: _registerPassword,
    );
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
    } else {
      Navigator.pop(context);
    }
    setState(() {
      _registerFormLoading = false;
    });
  }

  bool _registerFormLoading = false;

  String _registerEmail = '';
  String _registerPassword = '';
  String _registerName = '';

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
        shrinkWrap: false,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Create A New Account',
              textAlign: TextAlign.center,
              style: Constants.boldHeading,
            ),
          ),
          Column(
            children: [
              CustomInput(
                textInputType: TextInputType.name,
                hintText: 'Name...',
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  _registerName = value;
                },
              ),
              CustomInput(
                textInputType: TextInputType.emailAddress,
                hintText: 'Email...',
                textInputAction: TextInputAction.next,
                onChanged: (value) {
                  _registerEmail = value;
                },
              ),
              CustomInput(
                textInputType: TextInputType.emailAddress,
                hintText: 'Password...',
                textInputAction: TextInputAction.next,
                isPasswordFeild: !_passwordVisibility,
                onChanged: (value) {
                  _registerPassword = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PasswordVisibilityCheckBox(
                  (value) {
                    setState(
                      () {
                        _passwordVisibility = value;
                      },
                    );
                  },
                  _passwordVisibility,
                ),
              ),
              CustomBtn(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                text: 'Create New Account',
                onPressed: () {
                  if (_registerEmail.isNotEmpty &&
                      _registerName.isNotEmpty &&
                      _registerPassword.isNotEmpty) {
                    _submitForm();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('All fields are necessary'),
                      ),
                    );
                  }
                },
                isLoading: _registerFormLoading,
              ),
            ],
          ),
          CustomBtn(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            outlineBtn: true,
            text: 'Already have an account?',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
