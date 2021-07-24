import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;
  final EdgeInsets padding;
  final double width;

  const CustomBtn({
    Key key,
    this.text,
    this.onPressed,
    this.outlineBtn,
    this.isLoading,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        width: width,
        margin: padding,
        decoration: BoxDecoration(
          color: Constants.btnColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            Constants.boxShadow,
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text == null ? 'Text' : text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Constants.regularProgressIndicator,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
