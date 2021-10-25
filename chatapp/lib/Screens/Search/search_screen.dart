import 'package:chatapp/Screens/Search/components/body.dart';
import 'package:chatapp/methods.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
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
