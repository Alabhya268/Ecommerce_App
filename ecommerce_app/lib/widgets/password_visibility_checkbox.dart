import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class PasswordVisibilityCheckBox extends StatefulWidget {
  final Function passwordVisibility;
  final bool isPasswordVisible;

  const PasswordVisibilityCheckBox(
      this.passwordVisibility, this.isPasswordVisible);

  @override
  _PasswordVisibilityCheckBoxState createState() =>
      _PasswordVisibilityCheckBoxState();
}

class _PasswordVisibilityCheckBoxState
    extends State<PasswordVisibilityCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isPasswordVisible,
          onChanged: widget.passwordVisibility,
        ),
        Text(
          'Show password',
          style: Constants.regularDark,
        ),
      ],
    );
  }
}
