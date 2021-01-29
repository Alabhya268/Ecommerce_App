import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final String uid;

  const CustomActionBar({Key key, this.title, this.hasBackArrow, this.hasTitle, this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrow ?? false;
    bool _hasTitle = hasTitle ?? true;

      final Stream<QuerySnapshot> _userRef =
      FirebaseFirestore.instance.collection('Cart').where('uid', isEqualTo: uid).snapshots();
      
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
            child: StreamBuilder<QuerySnapshot>(
              stream: _userRef,
              builder: (context, snapshot) {
                int _totalItem = 0;

                if(snapshot.connectionState == ConnectionState.active) {
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
        ],
      ),
    );
  }
}
