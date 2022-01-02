import 'package:firebase_flutter/services/auth.dart';
import 'package:firebase_flutter/shared/constants.dart';
import 'package:firebase_flutter/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    if (loading)
      return Loading();
    else {
      return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text('Sign In'),
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Register',
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
            key: _formKey,
            child: Column(children: [
              SizedBox.fromSize(
                size: Size.fromHeight(20.0),
              ),
              TextFormField(
                validator: (val) => val!.isEmpty ? 'Write a valid email' : null,
                onChanged: (val) {
                  //Do something with the user input.
                  setState(() {
                    email = val;
                  });
                },
                decoration: textInputDecoration.copyWith(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )),
              ),
              SizedBox.fromSize(
                size: Size.fromHeight(20.0),
              ),
              TextFormField(
                obscureText: true,
                validator: (val) => val!.length < 6
                    ? 'Password should be longer than 6 chars'
                    : null,
                onChanged: (val) {
                  //Do something with the user input.
                  setState(() {
                    password = val;
                  });
                },
                decoration: textInputDecoration
                    .copyWith(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))
                    .copyWith(hintText: 'Password'),
              ),
              SizedBox.fromSize(
                size: Size.fromHeight(20.0),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.pink),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic res = await _authService.signInWithEmailAndPassword(
                        email, password);
                    setState(() {
                      loading = false;
                    });
                    if (res == null) {
                      setState(() {
                        error = 'Error ! Unable to sign in';
                      });
                    }
                  }
                },
                child: Text('Sign In'),
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ]),
          ),
        ),
      );
    }
  }
}
