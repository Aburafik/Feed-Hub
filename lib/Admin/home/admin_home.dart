import 'package:feed_hub/Admin/donations/recent_donations.dart';
import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Controllers/getData_controller.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class AdminHomeVC extends StatelessWidget {
  AdminHomeVC({super.key});
  final DataController dataController = Get.put(DataController());

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
                children: [
                  DashBoardSummaryCard(
                    title: "Total NGOs",
                    subTitle: dataController.allNGOs.toString(),
                    icon: Icons.person_add,
                  ),
                  DashBoardSummaryCard(
                    title: "Total Users",
                    subTitle: dataController.allUsers.toString(),
                    icon: Icons.person_add,
                  ),
                  DashBoardSummaryCard(
                    title: "Total Donations",
                    subTitle: dataController.allDonations.toString(),
                    icon: Icons.person_add,
                  ),
                ],
              ),
              Expanded(child: RecentDonationsComponent())
            ],
          )),
    );
  }
}

class DetailsWidgetComponent extends StatelessWidget {
  const DetailsWidgetComponent({Key? key, this.leading, this.trailing})
      : super(key: key);
  final String? trailing;
  final String? leading;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading!),
          Text(trailing!),
        ],
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
