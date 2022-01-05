import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/services/auth.dart';
import 'package:firebase_flutter/shared/constants.dart';
import 'package:firebase_flutter/shared/loading.dart';
import 'package:flutter/material.dart';

class CodeAlert extends StatefulWidget {
  final String verificationId;

  FirebaseAuth auth;

  CodeAlert(this.verificationId, this.auth);

  @override
  _CodeAlertState createState() => _CodeAlertState();
}

class _CodeAlertState extends State<CodeAlert> {
  String _code = '';
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _error = '';
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    if (!_isLoading) {
      return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.0),
            Text(
              'Enter SMS Verification Code ',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              validator: (val) => val!.isEmpty ? 'Enter Validation Code' : null,
              onChanged: (val) {
                setState(() {
                  _code = val;
                });
              },
              decoration: textInputDecoration
                  .copyWith(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ))
                  .copyWith(hintText: 'Validation Code'),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(20.0),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  dynamic res = await auth.signInWithSmsCode(
                      _code, widget.verificationId);
                  setState(() {
                    _isLoading = false;
                  });
                  Navigator.pop(context);
                  if (res == null) {
                    print('ERROR Signing in with SMS code');
                    setState(() {
                      _error = 'Error Signing in with SMS code';
                    });
                  }
                }
              },
              child: Text('Sign In'),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(20.0),
            ),
            Text(
              _error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
          ],
        ),
      );
    } else {
      return Loading();
    }
  }
}
