import 'package:chatapp/Screens/Home/components/body.dart';
import 'package:chatapp/methods.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomeScreen"),
        actions: [
          IconButton(onPressed: () => logOut(context), icon: Icon(Icons.logout))
        ],
      ),
      body: Body(),
    );
  }
}
