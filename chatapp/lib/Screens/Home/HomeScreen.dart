import 'package:chatapp/Screens/Home/components/body.dart';
import 'package:chatapp/Screens/Search/search_screen.dart';
import 'package:flutter/material.dart';

import '../../methods.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SearchScreen()));
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () => logOut(context), icon: Icon(Icons.logout))
        ],
      ),
      body: Body(),
    );
  }
}
