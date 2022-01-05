import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/shared/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20.0),

            Text('Enter SMS Verification Code ',
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
                  var _credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId, smsCode: _code);
                  print('Credentials '+ _credential.toString());
                  dynamic res =
                      await widget.auth.signInWithCredential(_credential);
                  Navigator.pop(context);
                  print('RES : ' + res);
                  if (res == null) {
                    print('ERROR');
                  }
                }
              },
              child: Text('Sign In'),
            ),
          ],
        ),
    );
  }
}
