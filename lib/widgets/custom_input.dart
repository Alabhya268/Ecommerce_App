import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final Function(String) validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordFeild;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final EdgeInsets padding;

  const CustomInput({
    Key key,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.isPasswordFeild,
    this.textInputType,
    this.textEditingController,
    this.validator,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding ??
          EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(
          0xFF323232,
        ),
      ),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: isPasswordFeild ?? false,
        focusNode: focusNode,
        onChanged: onChanged,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          border: InputBorder.none,
          hintText: hintText ?? 'Hint Text...',
        ),
        style: Constants.regularDark,
      ),
    );
  }
}
