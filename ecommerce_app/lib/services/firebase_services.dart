import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return firebaseAuth.currentUser.uid;
  }

  User getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  final CollectionReference commentRef =
      FirebaseFirestore.instance.collection("comment");

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('Products');

  final CollectionReference cartRef =
      FirebaseFirestore.instance.collection('Cart');

  final CollectionReference savedRef =
      FirebaseFirestore.instance.collection('Saved');

  Future<String> createAccount({
    String name,
    String email,
    String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      UserModel userModel = new UserModel(
          uid: user.uid,
          name: name,
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

  Future<bool> emailExist(String email) async {
    bool isEmailExist = false;
    await usersRef.where('email', isEqualTo: email).get().then(
      (value) {
        if (value.docs.first.exists) {
          isEmailExist = true;
        }
      },
    ).onError(
      (error, stackTrace) {
        isEmailExist = false;
      },
    );
    return isEmailExist;
  }
}
