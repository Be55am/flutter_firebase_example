import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/models/user.dart' as appUser;
import 'package:firebase_flutter/screens/authenticate/code_alert.dart';
import 'package:firebase_flutter/services/database.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  appUser.User? _userFromFirebaseUser(User? user) {
    return user != null ? appUser.User(uid: user.uid) : null;
  }

  // Sign in Anonymously
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return _userFromFirebaseUser(userCredential.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with phone number
  Future signInWithPhoneNumber(String phoneNumber, BuildContext context) async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential){
          _auth.signInWithCredential(authCredential).then((value) => {
            print(value.toString())
          });
        },
        verificationFailed: (FirebaseAuthException exception){
          print(exception);
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          //show dialog to take input from the user
          print('You should ask User to insert the verification code manually');

          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                  child: CodeAlert(verificationId, _auth),
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId){
          verificationId = verificationId;
          print(verificationId);
          print("Timout");
        },
    ).catchError((e){print(e);});

  }

  // auth change user stream
  Stream<appUser.User?> get user {
    return _auth
        .authStateChanges()
        // .map((firebaseUser) => _userFromFirebaseUser(firebaseUser));
        .map(_userFromFirebaseUser);
  }

// Sign in with Email and Password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return _userFromFirebaseUser(userCredential.user);
    }catch(e){
      print(e);
      return null;
    }
  }

// Register with Email and Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      await DatabaseService(uid: userCredential.user!.uid)
          .updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(userCredential.user);
    } catch (e) {
      print(e);
      return null;
    }
  }

// Signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
