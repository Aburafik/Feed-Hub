import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Controllers/organizations_controller.dart';
import 'package:feed_hub/Services/dynamic_link.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/images.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeVC extends StatelessWidget {
  HomeVC({super.key});
  final OrganizationsController controller =
      Get.find<OrganizationsController>();
  final Stream<QuerySnapshot> organizations =
      FirebaseFirestore.instance.collection('organizations').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: organizations,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: Text("Wating for Data"));
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == null) {
                return const Center(child: Text("No Dtata"));
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeBanner(),
                    HomeHeadingComponent(
                      leading: "Recent NGOs Request",
                      onTap: () => Get.toNamed(RouterHelper.allNgoListView,
                          arguments: controller.organizations),
                    ),
                    SizedBox(
                      height: 230,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return NGosCard(
                              recentOrganizations:
                                  controller.organizations[index],
                              organizations: controller.organizations,
                            );
                          }),
                    ),
                    HomeHeadingComponent(
                      leading: "Others Request",
                      onTap: () => Get.toNamed(RouterHelper.allNgoListView,
                          arguments: controller.organizations),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.organizations.length > 3 ? 3 : 2,
                        itemBuilder: (context, index) {
                          return OtherRequestCardComponent(
                            organizations: controller.organizations[index],
                          );
                        })
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class OtherRequestCardComponent extends StatelessWidget {
  const OtherRequestCardComponent({Key? key, this.organizations})
      : super(key: key);
  final dynamic organizations;
  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.bodyText1!;

    return GestureDetector(
      onTap: () =>
          Get.toNamed(RouterHelper.homeDetailsView, arguments: organizations),
      child: Card(
        child: SizedBox(
          height: 100,
          width: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              Card(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(
                    organizations['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    organizations['organizationName'],
                    style: style.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 15,
                        color: Colors.grey,
                      ),
                      Text(
                        organizations['location'],
                      )
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.yellow,
                      ),
                      Text("4.5")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeadingComponent extends StatelessWidget {
  const HomeHeadingComponent({Key? key, this.leading, this.onTap})
      : super(key: key);
  final String? leading;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leading!,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "View All",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}

class NGosCard extends StatelessWidget {
  const NGosCard({Key? key, this.recentOrganizations, this.organizations})
      : super(key: key);
  final dynamic recentOrganizations;
  final dynamic organizations;
  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.bodyText1!;
    return GestureDetector(
      onTap: () => Get.toNamed(RouterHelper.homeDetailsView,
          arguments: recentOrganizations),
      child: Card(
        child: SizedBox(
          height: 220,
          width: 200,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            recentOrganizations['image'],
                          ),
                          fit: BoxFit.contain)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Feed Hungry Child",
                      style: style.copyWith(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Child Care Foundation"),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 5),
                      child: LinearPercentIndicator(
                        padding: EdgeInsets.zero,
                        barRadius: const Radius.circular(5),
                        width: 180,
                        lineHeight: 5.0,
                        percent: 0.6,
                        backgroundColor: Colors.grey[300],
                        progressColor: AppColors.primaryColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Target: 50",
                          style: style,
                        ),
                        Text("65%",
                            style: style.copyWith(
                              color: AppColors.primaryColor,
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeBanner extends StatelessWidget {
  HomeBanner({
    Key? key,
  }) : super(key: key);
  final DynamicLinks creatLink = DynamicLinks();
  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: AppColors.whiteColor, fontSize: 16);
    return Container(
      height: MediaQuery.of(context).size.height / 5.5,
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            AppColors.primaryLightColor,
            AppColors.primaryColor,
          ]),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Do you have some", style: style),
              Text(
                "food to donate?",
                style: style,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Donate Now -->",
                  style: style,
                ),
              ),
             
            ],
          ),
          Image.asset(
            Images.food,
            height: 100,
          )
        ],
      ),
    );
  }
}
