import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

Widget message(Size size, Map<String, dynamic> map, BuildContext context) {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  return Container(
    width: size.width,
    alignment: map['sendby'] == _auth.currentUser.displayName
        ? Alignment.centerRight
        : Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: map['sendby'] == _auth.currentUser.displayName
            ? kPrimaryColor
            : Colors.blue,
      ),
      child: Text(
        map['message'],
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
