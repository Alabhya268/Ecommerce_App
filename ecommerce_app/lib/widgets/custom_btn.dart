import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;

  const CustomBtn({Key key, this.text, this.onPressed, this.outlineBtn});

  @override
  Widget build(BuildContext context) {
    bool _outlineBtn = outlineBtn ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 24,
        ),
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          borderRadius: BorderRadius.circular(
            12,
          ),
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Text(
          text == null ? 'Text' : text,
          style: TextStyle(
            color: _outlineBtn ? Colors.black : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
