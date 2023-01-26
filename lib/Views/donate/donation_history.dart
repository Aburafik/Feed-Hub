import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonationHistoryVC extends StatelessWidget {
  DonationHistoryVC({super.key});
  static String userId = FirebaseAuth.instance.currentUser!.uid;

  final Stream<QuerySnapshot> myDonationHistory = FirebaseFirestore.instance
      .collection('donations')
      .doc(userId)
      .collection("my-donations")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: myDonationHistory,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                dynamic data = snapshot.data!.docs[index].data();
                return Card(
                  child: ListTile(
                    title: const Text("Donation Name"),
                    subtitle: const Text("erjfjnfvjf"),
                    leading: const Icon(Icons.check_circle_outline),
                    trailing: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                        color:
                            data['status'] ? Colors.green : Color(0xffF7682B),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                          child: Text(data['status'] ? "Recieved" : "Pending"),
                        )),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
