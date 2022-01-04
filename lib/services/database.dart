import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/models/brew.dart';
import 'package:firebase_flutter/models/user_data.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  // collection reference
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Brew(
        name: doc.get('name'),
        strength: doc.get('strength'),
        sugars: doc.get('sugars'),
      );
    }).toList();
  }

  // UserData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot? snapshot) {
    return UserData(
      uid: snapshot!.id,
      name: snapshot.get('name'),
      strength: snapshot.get('strength'),
      sugars: snapshot.get('sugars'),
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
