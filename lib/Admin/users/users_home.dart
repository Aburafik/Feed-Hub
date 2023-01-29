import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Controllers/getData_controller.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class UsersHomeVC extends StatelessWidget {
  UsersHomeVC({
    Key? key,
  }) : super(key: key);
  final Stream<QuerySnapshot> recentDonations =
      FirebaseFirestore.instance.collection('users').snapshots();
  final DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: 
      Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                children: [
                  Text("USERS",
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
                  final users = snapshot.data!.docs.reversed;
                  dataController.getAllUser(users.length);
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
                        DataColumn(label: Expanded(child: Text("User Name"))),
                        DataColumn(label: Text("User Email")),
                        DataColumn(label: Text("User Contact")),
                        DataColumn(label: Text("User Location")),
                        // DataColumn(label: Text("Donation Details")),
                      ],
                      rows: users
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e['userName'])),
                                DataCell(Text(e["email"])),
                                DataCell(Text(e["contact"])),
                                DataCell(Text(e["location"])),
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
