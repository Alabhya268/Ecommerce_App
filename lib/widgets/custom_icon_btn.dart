import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomIconBtn extends StatelessWidget {
  final Function onPressed;
  final double height;
  final double width;
  final EdgeInsets margin;
  final Icon icon;

  const CustomIconBtn({
    this.onPressed,
    this.height,
    this.width,
    this.icon,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin,
        height: height ?? 65,
        width: width ?? 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Constants.btnColor,
          boxShadow: [
            Constants.boxShadow,
          ],
        ),
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
