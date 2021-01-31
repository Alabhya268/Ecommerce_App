import 'dart:ffi';

import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordFeild;
  final TextInputType textInputType;
  final double horizontalPadding;

  const CustomInput({
    Key key,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.isPasswordFeild,
    this.textInputType,
    this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: horizontalPadding ?? 24,
      ),
      decoration: BoxDecoration(
        color: Color(
          0xFFF2F2F2,
        ),
      ),
      child: TextField(
        keyboardType: textInputType,
        obscureText: isPasswordFeild ?? false,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          border: InputBorder.none,
          hintText: hintText ?? 'Hint Text...',
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
