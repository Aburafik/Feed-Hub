import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:flutter/material.dart';

class AllDonations extends StatelessWidget {
  AllDonations({
    Key? key,
  }) : super(key: key);
  final Stream<QuerySnapshot> recentDonations =
      FirebaseFirestore.instance.collection('AllDonations').snapshots();
  List allDonations = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                children: [
                  Text("All Donations",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: recentDonations,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final donations = snapshot.data!.docs.reversed;

                  print(donations.map((e) => e['dishName']));
                  return DataTable(
                      dataTextStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                              color: Colors.black, fontWeight: FontWeight.bold),
                      headingTextStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: const Color(0xff747889)),
                      headingRowHeight: 30,
                      horizontalMargin: 20,
                      headingRowColor: MaterialStateProperty.all(
                          AppColors.adminPrimaryColor),
                      columns: const [
                        DataColumn(label: Expanded(child: Text("Sender Name"))),
                        DataColumn(label: Text("Sender Location")),
                        DataColumn(label: Text("Sender Contact")),
                        DataColumn(label: Text("Pick Up Date")),
                        DataColumn(label: Text("Pick Up Location")),
                        DataColumn(label: Text("Donation Status")),
                        // DataColumn(label: Text("Donation Details")),
                      ],
                      rows: donations
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e['senderName'])),
                                DataCell(Text(e["senderLocation"])),
                                DataCell(Text(e["senderContact"])),
                                DataCell(Text(e["pickUpDate"])),
                                DataCell(Text(e["pickUpLocation"])),
                                DataCell(
                                  Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    color: e['status']
                                        ? Colors.green
                                        : const Color(0xffF7682B),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 5),
                                      child: Text(
                                        e['status'] ? "Recieved" : "Pending",
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                // DataCell(
                                //   Material(
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(5)),
                                //       color: AppColors.activeColor,
                                //       child: const Padding(
                                //         padding: EdgeInsets.symmetric(
                                //             vertical: 5, horizontal: 15),
                                //         child: Text(
                                //           "View",
                                //           style: TextStyle(fontSize: 10),
                                //         ),
                                //       )),
                                // ),
                              ]))
                          .toList());
                } else {
                  return const Expanded(
                    child: Center(
                      child: Text("No Data"),
                    ),
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }

  Padding donationDetailsHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black,
              )),
    );
  }
}
