import 'package:firebase_flutter/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(children: [
            SizedBox.fromSize(
              size: Size.fromHeight(20.0),
            ),
            TextFormField(
              onChanged: (val) {
                //Do something with the user input.
                setState(() {
                  email = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Email',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(20.0),
            ),
            TextFormField(
              obscureText: true,
              onChanged: (val) {
                //Do something with the user input.
                setState(() {
                  password = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(20.0),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
                onPressed: () async {
                print(email + ' ' + password);
                },
                child: Text('Sign In'),
            ),
          ]),
        ),
      ),
    );
  }
}
