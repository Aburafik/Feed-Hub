import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Utils/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationHistoryVC extends StatelessWidget {
  DonationHistoryVC({super.key});
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final Stream<QuerySnapshot> myDonationHistory = FirebaseFirestore.instance
      .collection('AllDonations')
      .orderBy('created', descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    print("############User ID $userId####################");
    return Scaffold(
      body: StreamBuilder(
        stream: myDonationHistory,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  dynamic data = snapshot.data!.docs[index].data();

                  var dateTime =
                      DateTime.fromMillisecondsSinceEpoch(data['created']);

                  var formatTime =
                      DateFormat('k:mm a').format(dateTime).toString();
                  var formatDate =
                      DateFormat('EEE, M/d/y').format(dateTime).toString();
                  /////
                  return !data["userId"].toString().contains(userId)
                      ? Wrap()
                      // Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       SizedBox(
                      //           height:
                      //               MediaQuery.of(context).size.height / 2.5),
                      //       Image.asset(
                      //         Images.folder,
                      //         height: 80,
                      //       ),
                      //       const Text("No Donaton Histroy"),
                      //     ],
                      //   )
                      : data["userId"] == userId
                          ? Card(
                              child: ListTile(
                                title: Text(
                                  "Donated to\n${data["name"]}",
                                  style: TextStyle(fontSize: 14),
                                ),
                                subtitle: Text(
                                  formatDate,
                                  style: TextStyle(fontSize: 12),
                                ),
                                leading: const Icon(
                                  Icons.check_circle_outline,
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Material(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      color: data['status']
                                          ? Colors.green
                                          : const Color(0xffF7682B),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 5),
                                        child: Text(
                                          data['status']
                                              ? "Recieved"
                                              : "Pending",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      formatTime,
                                      style: TextStyle(fontSize: 11),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        2.5),
                                Image.asset(
                                  Images.folder,
                                  height: 80,
                                ),
                                const Text("No Donaton Histroy"),
                              ],
                            );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
