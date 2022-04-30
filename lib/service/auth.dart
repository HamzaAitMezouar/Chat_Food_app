import 'package:converchat/models/User.dart';
import 'package:converchat/service/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  myUser? userCred(User user) {
    return user != null ? myUser(user.email!) : null;
  }

  Stream<User> get user {
    return _auth.authStateChanges().map((User? user) => user!);
  }

// Sign In email
  Future signInEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
      User user = result.user!;
      await datab(user.uid).getDb();
      print(user.email);
      return userCred(user);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
      print('catch');
    }
  }

//Register
  Future registerEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(result);
      User user = result.user!;
      print(user.email);
      return userCred(user);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
      print('catch register');
    }
  }
//Sign ouuuut

  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
      print('catch sign out ');
    }
  }

  Future AuthAno() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return user;
    } catch (e) {
      e.toString();
      return null;
    }
  }
}
