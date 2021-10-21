import 'package:chatapp/Screens/Login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<User> createAccount(String name, String email, String password) async {
  try {
    User user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Create Successfull");
      return user;
    } else {
      print("Account Fail");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User> logIn(String email, String password) async {
  try {
    User user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Login Successfull");
      return user;
    } else {
      print("Failed Login");
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  try {
    await _auth.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  } catch (e) {
    print("error in logout");
  }
}
