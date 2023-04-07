import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Admin/home/admin_home.dart';
import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Controllers/getData_controller.dart';
import 'package:feed_hub/Services/auth_service.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
// import 'package:get/utils.dart';

class RecentDonationsComponent extends StatelessWidget {
  RecentDonationsComponent({
    Key? key,
  }) : super(key: key);
  final Stream<QuerySnapshot> recentDonations = FirebaseFirestore.instance
      .collection('AllDonations')
      .orderBy('created', descending: false)
      .snapshots();
  final _db = FirebaseFirestore.instance;
  final DataController dataController = Get.put(DataController());
  AuthUser authUser = AuthUser();
  @override
  Widget build(BuildContext context) {
    TextStyle style =
        Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16);
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
                  Text(
                    "Recent Donations",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: recentDonations,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final donations = snapshot.data!.docs.reversed.toList();
                    dataController.getAllDonations(donations.length);
                    return SingleChildScrollView(
                      child: DataTable(
                          dataTextStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                          headingTextStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color:
                                      const Color.fromARGB(255, 201, 202, 206)),
                          headingRowHeight: 30,
                          horizontalMargin: 20,
                          headingRowColor: MaterialStateProperty.all(
                              AppColors.adminPrimaryColor),
                          columns: const [
                            DataColumn(
                                label: Expanded(child: Text("Sender Name"))),
                            DataColumn(label: Text("Sender Location")),
                            DataColumn(label: Text("Sender Contact")),
                            DataColumn(label: Text("Pick Up Date")),
                            DataColumn(label: Text("Pick Up Location")),
                            DataColumn(label: Text("Donation Status")),
                            DataColumn(label: Text("Donation Details")),
                          ],
                          rows: donations
                              .map((e) => DataRow(cells: [
                                    DataCell(
                                        Text(e['senderName'], style: style)),
                                    DataCell(Text(e["senderLocation"],
                                        style: style)),
                                    DataCell(
                                        Text(e["senderContact"], style: style)),
                                    DataCell(
                                        Text(e["pickUpDate"], style: style)),
                                    DataCell(Text(e["pickUpLocation"],
                                        style: style)),
                                    DataCell(
                                      Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        color: e['status']
                                            ? Colors.green
                                            : const Color(0xffF7682B),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 5),
                                          child: Text(
                                            e['status']
                                                ? "Recieved"
                                                : "Pending",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      GestureDetector(
                                        onTap: () {
                                          print(e.id);
                                          showDialog(
                                            context: context,
                                            builder: ((context) => AlertDialog(
                                                  backgroundColor: Colors.white
                                                      .withOpacity(0.9),
                                                  content: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .height,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          donationDetailsHeader(
                                                            context,
                                                            "SENDER DETAILS",
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading: "Sender:",
                                                            trailing:
                                                                e['senderName'],
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading:
                                                                "Sender Location:",
                                                            trailing: e[
                                                                'senderLocation'],
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading:
                                                                "Sender Contact:",
                                                            trailing: e[
                                                                'senderContact'],
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading:
                                                                "Item Sent:",
                                                            trailing:
                                                                e['dishName'],
                                                          ),
                                                          donationDetailsHeader(
                                                            context,
                                                            "DONATION DETAILS",
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading:
                                                                "Item Sent:",
                                                            trailing:
                                                                e['dishName'],
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading:
                                                                "Organization Donated to:",
                                                            trailing: e["name"],
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading:
                                                                "Quantity:",
                                                            trailing: e[
                                                                'foodQuantity'],
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading:
                                                                "Pick Up Date:",
                                                            trailing:
                                                                e['pickUpDate'],
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading:
                                                                "Pick Up Location:",
                                                            trailing: e[
                                                                'pickUpLocation'],
                                                          ),
                                                          DetailsWidgetComponent(
                                                            leading:
                                                                "Further Information:",
                                                            trailing: e[
                                                                'furtherInfor'],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                const Text(
                                                                    "Donation Status"),
                                                                Material(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              3)),
                                                                  color: e[
                                                                          'status']
                                                                      ? Colors
                                                                          .green
                                                                      : const Color(
                                                                          0xffF7682B),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            2,
                                                                        horizontal:
                                                                            5),
                                                                    child: Text(
                                                                      e['status']
                                                                          ? "Recieved"
                                                                          : "Pending",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          CommonButton(
                                                            buttonText: e[
                                                                    'status']
                                                                ? "ACCEPTED"
                                                                : "PENDING APPROVAL",
                                                            onPressed:
                                                                e['status']
                                                                    ? () {
                                                                        Get.back();
                                                                      }
                                                                    : () async {
                                                                        /////
                                                                        await _db
                                                                            .collection('AllDonations')
                                                                            .doc(e.id)
                                                                            .set(
                                                                          {
                                                                            "status":
                                                                                true
                                                                          },
                                                                          SetOptions(
                                                                            merge:
                                                                                true,
                                                                          ),
                                                                        );
                                                                        await AuthUser.sendPushMessageToUser(
                                                                            id: e['userId']);
                                                                        Get.back();
                                                                      },
                                                          )
                                                        ],
                                                      )),
                                                )),
                                          );
                                        },
                                        child: Material(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            color: AppColors.activeColor,
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 15),
                                              child: Text(
                                                "View",
                                                style: TextStyle(fontSize: 10),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ]))
                              .toList()),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Text("No Data"),
                      ),
                    );
                  }
                }),
              ),
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
