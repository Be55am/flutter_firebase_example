import 'package:firebase_flutter/screens/authenticate/phone_signin.dart';
import 'package:firebase_flutter/screens/authenticate/register.dart';
import 'package:firebase_flutter/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  int authView = 0;

  void toggleView(int view) {
    setState(() => authView = view);
  }

  @override
  Widget build(BuildContext context) {
    if (authView == 0)
      return SignIn(toggleView: toggleView);
    else if(authView == 1)
      return Register(toggleView: toggleView);
    else {
      return PhoneSignIn(toggleView: toggleView);
    }
  }
}
