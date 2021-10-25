import 'package:chatapp/Screens/ChatRoom/chatroom_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../methods.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic> userMap;
  List members = [];

  @override
  void initState() {
    super.initState();
    getAll();
  }

  Future<List<String>> getAll() async {
    await firestore.collection('users').get().then((value) {
      setState(() {
        for (int i = 0; i < value.size; i++) {
          userMap = value.docs[i].data();
          members.add(userMap['name']);
        }
      });
    });
    return members;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            String roomId =
                chatRoomId(_auth.currentUser.displayName, members[index]);
            print(members[index]);
            print(userMap['name']);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ChatRoomScreen(
                      chatRoomId: roomId,
                      members: members,
                      name: members[index],
                    )));
          },
          leading: Icon(Icons.account_box),
          title: Text(
            members[index],
            style: TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }
}
