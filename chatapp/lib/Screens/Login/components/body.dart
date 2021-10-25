import 'package:chatapp/Screens/Home/HomeScreen.dart';
import 'package:chatapp/Screens/Signup/signup_screen.dart';
import 'package:chatapp/components/already_have_an_account_acheck.dart';
import 'package:chatapp/components/rounded_button.dart';
import 'package:chatapp/components/rounded_input_field.dart';
import 'package:chatapp/components/rounded_password_field.dart';
import 'package:chatapp/methods.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController _email = TextEditingController();
    final TextEditingController _password = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Background(
      child: SingleChildScrollView(
        child: Form(
          autovalidate: true,
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
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
                  onChanged: (value) {},
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required*"),
                    MinLengthValidator(6,
                        errorText: "Should be at least 6 characters")
                  ])),
              isLoading
                  ? CircularProgressIndicator()
                  : RoundedButton(
                      text: "LOGIN",
                      press: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          logIn(_email.text, _password.text).then((user) {
                            if (user != null) {
                              print("Login Succesful");
                              setState(() {
                                isLoading = false;
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Can not Login"),
                                backgroundColor: Theme.of(context).errorColor,
                              ));
                            }
                          });
                        }
                      },
                    ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
