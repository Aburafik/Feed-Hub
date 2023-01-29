import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AdminHomeVC extends StatelessWidget {
  const AdminHomeVC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDFDFD),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  DashBoardSummaryCard(
                    title: "Total NGOs",
                    subTitle: "30",
                    icon: Icons.person_add,
                  ),
                  DashBoardSummaryCard(
                    title: "Total Users",
                    subTitle: "10",
                    icon: Icons.person_add,
                  ),
                  DashBoardSummaryCard(
                    title: "Total Donations",
                    subTitle: "40",
                    icon: Icons.person_add,
                  ),
                ],
              ),
              RecentDonationsComponent()
            ],
          )),
    );
  }
}

class RecentDonationsComponent extends StatelessWidget {
  RecentDonationsComponent({
    Key? key,
  }) : super(key: key);
  final Stream<QuerySnapshot> recentDonations =
      FirebaseFirestore.instance.collection('AllDonations').snapshots();

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
                  Text("Recent Donations",
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
                  final donations = snapshot.data!.docs;

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
                        DataColumn(label: Text("NGO Donated To")),
                        DataColumn(label: Text("PickUp Location")),
                        DataColumn(label: Text("Donation Details")),
                      ],
                      rows: donations
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e['senderName'])),
                                DataCell(Text(e["senderLocation"])),
                                DataCell(Text(e["senderLocation"])),
                                DataCell(Text(e["senderContact"])),
                                DataCell(Text(e["pickUpLocation"])),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      // print(e['senderLocation']);
                                      donateSuccessMessage(context: context);
                                    },
                                    child: Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        color: AppColors.activeColor,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          child: Text("View"),
                                        )),
                                  ),
                                ),
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
}

donateSuccessMessage({BuildContext? context}) {
  Get.defaultDialog(
      backgroundColor: AppColors.whiteColor.withOpacity(0.7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      title: "",
      content: SizedBox(
        width: MediaQuery.of(context!).size.width / 4,
        height: MediaQuery.of(context).size.height / 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.check, color: AppColors.whiteColor, size: 50),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Success",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20),
                ),
              ),
              Text(
                "Your donation request was sent successfully",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 16),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
      confirm: SizedBox(
        // width: MediaQuery.of(context).size.width,
        child: CommonButton(
            buttonText: "Done",
            onPressed: () {
              Get.toNamed(RouterHelper.dashBoard);
            }),
      ));
}

class DashBoardSummaryCard extends StatelessWidget {
  const DashBoardSummaryCard({Key? key, this.subTitle, this.title, this.icon})
      : super(key: key);
  final String? title;
  final String? subTitle;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
          height: 150,
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: AppColors.adminPrimaryColor,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title!,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 10),
                    Text(subTitle!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
