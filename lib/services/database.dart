import 'package:brewi_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brewi_crew/models/brew.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData (String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot (QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        name: doc.data()['name'] ?? '',
        sugars: doc.data()['sugars'] ?? '0',
        strength: doc.data()['strength'] ?? 0,
      );
    }).toList();
  }

  // userPreference(userData) from snapshot
  UserPreference _userDataFromSnapshot (DocumentSnapshot snapshot) {
    return UserPreference(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }

  // Get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // Get user doc stream
  Stream<UserPreference> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}

