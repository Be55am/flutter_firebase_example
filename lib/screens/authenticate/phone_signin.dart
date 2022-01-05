import 'package:firebase_flutter/services/auth.dart';
import 'package:firebase_flutter/shared/constants.dart';
import 'package:firebase_flutter/shared/loading.dart';
import 'package:flutter/material.dart';

class PhoneSignIn extends StatefulWidget {
  final Function toggleView;

  PhoneSignIn({required this.toggleView});

  @override
  _PhoneSignInState createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String phoneNumber = '';
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
                widget.toggleView(1);
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'),
                  fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox.fromSize(
                size: Size.fromHeight(20.0),
              ),
              TextFormField(
                validator: (val) =>
                    val!.isEmpty ? 'Write a valid phone number' : null,
                keyboardType: TextInputType.phone,
                onChanged: (val) {
                  //Do something with the user input.
                  setState(() {
                    phoneNumber = val;
                  });
                },
                decoration: textInputDecoration
                    .copyWith(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))
                    .copyWith(hintText: 'Phone Number'),
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
                    print(phoneNumber);
                    dynamic res = await _authService.signInWithPhoneNumber(
                        phoneNumber, context);
                    print('signin with phone number: ' + res);
                    // setState(() {
                    //   loading = false;
                    // });
                    // if (res == null) {
                    //   setState(() {
                    //     error = 'Error ! Unable to sign in';
                    //   });
                    // }
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
