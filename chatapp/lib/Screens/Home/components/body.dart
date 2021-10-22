import 'package:chatapp/Screens/ChatRoom/chatroom_screen.dart';
import 'package:chatapp/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Map<String, dynamic> userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void onSearch() async {
    setState(() {
      isLoading = true;
    });
    try {
      await firestore
          .collection('users')
          .where("name", isEqualTo: _search.text.toLowerCase())
          .get()
          .then((value) {
        setState(() {
          userMap = value.docs[0].data();
          isLoading = false;
        });
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Data can not find"),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height / 20,
        ),
        Container(
          height: size.height / 14,
          width: size.width,
          alignment: Alignment.center,
          child: Container(
            height: size.height / 14,
            width: size.width / 1.2,
            child: TextField(
              controller: _search,
              decoration: InputDecoration(
                hintText: "Search",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height / 30,
        ),
        isLoading
            ? CircularProgressIndicator()
            : Container(
                width: MediaQuery.of(context).size.width / 3.5,
                child: RoundedButton(
                  press: onSearch,
                  text: "Search",
                ),
              ),
        userMap != null
            ? ListTile(
                onTap: () {
                  String roomId = chatRoomId(
                      _auth.currentUser.displayName, userMap['name']);
                  print(roomId);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ChatRoomScreen(
                            chatRoomId: roomId,
                            userMap: userMap,
                          )));
                },
                leading: Icon(Icons.account_box),
                title: Text(
                  userMap['name'],
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(userMap['email']),
              )
            : Expanded(
                child: Container(
                child: Center(
                  child: Text(
                    "No one in here",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ))
      ],
    );
  }
}
