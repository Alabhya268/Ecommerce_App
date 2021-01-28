import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;

  const CustomActionBar({Key key, this.title, this.hasBackArrow, this.hasTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(
        top: 45,
        left: 12,
        right: 12,
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                print('Tapped');
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                width: 42,
                height: 42,
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? 'Action Bar',
              style: Constants.boldHeading,
            ),
          Container(
            alignment: Alignment.center,
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '0',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
