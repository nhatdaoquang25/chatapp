import 'package:chatapp/methods.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () => logOut(context),
        child: Text("Log out"),
      ),
    );
  }
}
