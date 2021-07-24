import 'package:ecommerce_app/constants.dart';
import 'package:ecommerce_app/screens/cart_page.dart';
import 'package:ecommerce_app/services/firebase_services.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserTab extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserBtn(
              title: 'Cart',
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: Theme.of(context).accentColor,
                size: 36,
              ),
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CartPage();
                    },
                  ),
                );
              },
            ),
            UserBtn(
              title: 'Logout',
              icon: Icon(
                Icons.logout_outlined,
                color: Theme.of(context).accentColor,
                size: 36,
              ),
              func: () {
                _firebaseServices.firebaseAuth.signOut();
              },
            ),
          ],
        ),
      ],
    );
  }
}

class UserBtn extends StatelessWidget {
  const UserBtn({
    Key key,
    this.icon,
    this.func,
    this.title,
  }) : super(key: key);

  final Icon icon;
  final Function func;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: func,
        child: Container(
          margin: EdgeInsets.all(12),
          height: 65,
          decoration: BoxDecoration(
            color: Constants.btnColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              Constants.boxShadow,
            ],
          ),
          child: ListTile(
            title: Text(
              '$title',
              style: Constants.regularHeading,
            ),
            leading: icon,
          ),
        ),
      ),
    );
  }
}
