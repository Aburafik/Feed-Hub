import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final docRef = userCollection.doc(userId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        String userProfile = json.encode(data);

        pref.setString("user", userProfile);
        print(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
