import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('Products');

  final CollectionReference cartRef =
      FirebaseFirestore.instance.collection('Cart');

  final CollectionReference savedRef =
      FirebaseFirestore.instance.collection('Saved');

  Future<String> createAccount(
      {String email,
      String password,
      String name,
      String add1,
      String add2,
      int zipcode,
      String city}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      UserModel userModel = new UserModel(
          uid: user.uid,
          name: name,
          add1: add1,
          add2: add2,
          zipcode: zipcode,
          city: city,
          email: user.email,
          dateTime: DateTime.now());
      usersRef.doc(user.uid).set(userModel.toJson());

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return e.message;
    } catch (e) {
      return (e.toString());
    }
  }

  Future<String> signInAccount({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return e.message;
    } catch (e) {
      return (e.toString());
    }
  }
}
