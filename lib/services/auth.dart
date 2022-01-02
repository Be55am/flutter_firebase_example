import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/models/user.dart' as appUser;

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

  // auth change user stream
  Stream<appUser.User?> get user {
    return _auth
        .authStateChanges()
        // .map((firebaseUser) => _userFromFirebaseUser(firebaseUser));
        .map(_userFromFirebaseUser);
  }

// Sign in with Email and Password

// Register with Email and Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      print(userCredential);
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
