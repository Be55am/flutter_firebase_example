import 'package:firebase_flutter/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();

  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up'),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.login,
              color: Colors.white,
            ),
            label: Text('Sign In',
            style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
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
            TextFormField(
              obscureText: true,
              onChanged: (val) {
                //Do something with the user input.
                setState(() {
                  password = val;
                });
              },
              decoration: InputDecoration(
                hintText: 'Confirm Password',
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
              child: Text('Register'),
            ),
          ]),
        ),
      ),
    );
  }
}
