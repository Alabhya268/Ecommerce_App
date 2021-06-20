import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/cart_page.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;

  FirebaseServices _firebaseServices = FirebaseServices();

  CustomActionBar({Key key, this.title, this.hasBackArrow, this.hasTitle});

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;

    double statusBarHeight = MediaQuery.of(context).padding.top;

    Stream<QuerySnapshot> _userRef = FirebaseFirestore.instance
        .collection('Cart')
        .where('uid', isEqualTo: _firebaseServices.getCurrentUser().uid)
        .snapshots();

    return Container(
      decoration: BoxDecoration(color: Color(0xFF1F1F1F)),
      padding: EdgeInsets.only(
        top: 10 + statusBarHeight,
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
                  color: Constants.customColorOne,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                width: 42,
                height: 42,
                child: Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? 'Action Bar',
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Constants.btnColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  Constants.boxShadow,
                ],
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: _userRef,
                builder: (context, snapshot) {
                  int _totalItem = 0;

                  if (snapshot.connectionState == ConnectionState.active) {
                    List _documents = snapshot.data.docs;
                    _totalItem = _documents.length;
                  }
                  return Text(
                    '$_totalItem',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
