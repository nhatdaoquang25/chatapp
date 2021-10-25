import 'package:chatapp/Screens/ChatRoom/chatroom_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        SvgPicture.asset(
          "assets/icons/signup.svg",
          height: size.height * 0.35,
        ),
        SizedBox(height: 20),
        Center(
          child: Text(
            "MEMBERS ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: members.length == 0
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          String roomId = chatRoomId(
                              _auth.currentUser.displayName, members[index]);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ChatRoomScreen(
                                    chatRoomId: roomId,
                                    members: members,
                                    name: members[index],
                                  )));
                        },
                        leading: Icon(
                          Icons.account_box,
                          size: 40,
                        ),
                        title: Text(
                          members[index],
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        trailing: Icon(Icons.arrow_forward),
                      );
                    },
                  ))
      ],
    );
  }
}
