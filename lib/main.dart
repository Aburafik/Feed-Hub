import 'package:feed_hub/Admin/donations/all_donations.dart';

import 'package:feed_hub/Admin/home/admin_home.dart';
import 'package:feed_hub/Admin/ngos/ngos_home.dart';
import 'package:feed_hub/Admin/pushNotifications/push_notifications.dart';
import 'package:feed_hub/Admin/users/users_home.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:feed_hub/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'FEED HUB ADMIN',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backGroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          elevation: .5,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: AppColors.whiteColor,
          ),
          iconTheme: IconThemeData(color: AppColors.whiteColor),
        ),
      ),
      initialRoute:
          GetPlatform.isWeb ? RouterHelper.adminLogin : RouterHelper.signIn,
      getPages: RouterHelper.router,
    );
  }
}

List tabs = [
  {
    "title": "HOME",
    "icon": Icon(
      Icons.home,
      color: Colors.grey[300],
    ),
  },
  {
    "title": "NGOs",
    "icon": Icon(Icons.crop_original_rounded, color: Colors.grey[300]),
  },
  {
    "title": "DONATIONS",
    "icon": Icon(Icons.donut_large, color: Colors.grey[300]),
  },
  {
    "title": "USERS",
    "icon": Icon(Icons.person, color: Colors.grey[300]),
  },
  {
    "title": "PUSH NOTIFICATIONS",
    "icon": Icon(Icons.person, color: Colors.grey[300]),
  },
];

class WebDashboardVC extends StatefulWidget {
  const WebDashboardVC({super.key});

  @override
  State<WebDashboardVC> createState() => _WebDashboardVCState();
}

class _WebDashboardVCState extends State<WebDashboardVC> {
  String selectedTab = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            color: AppColors.adminPrimaryColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "FEEDHUB ADMIN",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Drawer(
                  width: 300,
                  backgroundColor: AppColors.adminPrimaryColor,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: tabs
                              .map(
                                (e) => Card(
                                  elevation: 0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  color: selectedTab == e['title']
                                      ? AppColors.adminPrimaryLightColor
                                      : AppColors.adminPrimaryColor,
                                  child: ListTile(
                                      onTap: () {
                                        setState(
                                            () => selectedTab = e['title']);
                                      },
                                      title: Text(
                                        "${e['title']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(color: Colors.grey[300]),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey[300],
                                      ),
                                      leading: e['icon']),
                                ),
                              )
                              .toList(),
                        ),
                        Card(
                          elevation: 0,
                          color: AppColors.adminPrimaryColor,
                          child: ListTile(
                            onTap: () {
                              Get.offNamed(RouterHelper.adminLogin);
                            },
                            title: Text(
                              "LOGOUT",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey[300]),
                            ),
                            leading: Icon(
                              FeatherIcons.logOut,
                              color: Colors.grey[300],
                            ),
                          ),
                        )
                      ]),
                ),
                Expanded(child: layOutViewScreen(page: selectedTab))
              ],
            ),
          )
        ],
      ),
    );
  }
}

layOutViewScreen({String? page}) {
  switch (page) {
    case "HOME":
      return AdminHomeVC();
    case "NGOs":
      return  NgOsHomeVC();

    case "DONATIONS":
      return AllDonations();

    case "USERS":
      return UsersHomeVC();
    case "PUSH NOTIFICATIONS":
      return PushNotifications();

    case "":
      return AdminHomeVC();
  }
}
