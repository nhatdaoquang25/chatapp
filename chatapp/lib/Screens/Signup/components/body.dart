import 'package:chatapp/Screens/Home/home_screen.dart';
import 'package:chatapp/Screens/Login/login_screen.dart';
import 'package:chatapp/Screens/Signup/components/social_icon.dart';
import 'package:chatapp/components/already_have_an_account_acheck.dart';
import 'package:chatapp/components/rounded_button.dart';
import 'package:chatapp/components/rounded_input_field.dart';
import 'package:chatapp/components/rounded_password_field.dart';
import 'package:chatapp/methods.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'background.dart';
import 'or_divider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              controller: _name,
              hintText: "Your Name",
              onChanged: (value) {},
            ),
            RoundedInputField(
              controller: _email,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: _password,
              onChanged: (value) {},
            ),
            isLoading
                ? CircularProgressIndicator()
                : RoundedButton(
                    text: "SIGNUP",
                    press: () {
                      if (_name.text.isNotEmpty &&
                          _email.text.isNotEmpty &&
                          _password.text.isNotEmpty) {
                        setState(() {
                          isLoading = true;
                        });
                        createAccount(_name.text, _email.text, _password.text)
                            .then((user) {
                          if (user != null) {
                            setState(() {
                              isLoading = false;
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => HomeScreen()));
                            print("loading succ");
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Can not Create Login"),
                              backgroundColor: Theme.of(context).errorColor,
                            ));
                          }
                        });
                      } else {
                        print("Please enter full");
                      }
                    },
                  ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
