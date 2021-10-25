import 'package:chatapp/Screens/Home/HomeScreen.dart';
import 'package:chatapp/Screens/Login/login_screen.dart';
import 'package:chatapp/Screens/Signup/components/social_icon.dart';
import 'package:chatapp/components/already_have_an_account_acheck.dart';
import 'package:chatapp/components/rounded_button.dart';
import 'package:chatapp/components/rounded_input_field.dart';
import 'package:chatapp/components/rounded_password_field.dart';
import 'package:chatapp/methods.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Form(
          autovalidate: true,
          key: _formKey,
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
                validator: RequiredValidator(errorText: "Required*"),
              ),
              RoundedInputField(
                controller: _email,
                hintText: "Your Email",
                validator: MultiValidator([
                  RequiredValidator(errorText: "Required*"),
                  EmailValidator(errorText: "Not A Valid Email")
                ]),
              ),
              RoundedPasswordField(
                  controller: _password,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required*"),
                    MinLengthValidator(6,
                        errorText: "Should be at least 6 characters")
                  ])),
              isLoading
                  ? CircularProgressIndicator()
                  : RoundedButton(
                      text: "SIGNUP",
                      press: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          createAccount(_name.text.toLowerCase(), _email.text,
                                  _password.text)
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
      ),
    );
  }
}
