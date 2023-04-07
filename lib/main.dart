import 'dart:convert';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:feed_hub/Admin/chats/chats.dart';
import 'package:feed_hub/Admin/donations/all_donations.dart';
import 'package:feed_hub/Admin/home/admin_home.dart';
import 'package:feed_hub/Admin/ngos/ngos_home.dart';
import 'package:feed_hub/Admin/pushNotifications/push_notifications.dart';
import 'package:feed_hub/Admin/users/users_home.dart';
import 'package:feed_hub/Services/dynamic_link.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:feed_hub/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DynamicLinks initLink = DynamicLinks();
  @override
  void initState() {
    checkUserStatus();

    super.initState();
  }

  String? userName;
  checkUserStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userInfor = pref.getString('user');
    Map<String, dynamic> user = json.decode(userInfor!);
    setState(() {
      userName = user['userName'];
    });

    print("#########$userName###########");
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityAppWrapper(
      app: GetMaterialApp(
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
        initialRoute: GetPlatform.isWeb
            ? RouterHelper.adminLogin
            : userName == null
                ? RouterHelper.signIn
                : RouterHelper.dashBoard,
        getPages: RouterHelper.router,
      ),
    );
  }
}

List tabs = [
  {
    "title": "HOME",
    "icon": Icon(FeatherIcons.home, color: Colors.grey[300], size: 20),
  },
  {
    "title": "NGOs",
    "icon": Icon(FeatherIcons.square, color: Colors.grey[300], size: 20),
  },
  {
    "title": "DONATIONS",
    "icon": Icon(Icons.donut_large, color: Colors.grey[300], size: 20),
  },
  {
    "title": "USERS",
    "icon": Icon(
      FeatherIcons.user,
      color: Colors.grey[300],
      size: 20,
    ),
  },
  {
    "title": "PUSH NOTIFICATIONS",
    "icon": Icon(FeatherIcons.bell, color: Colors.grey[300], size: 20),
  },
  {
    "title": "CHATS",
    "icon": Icon(FeatherIcons.messageCircle, color: Colors.grey[300], size: 20),
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
                                      trailing: Icon(Icons.arrow_forward_ios,
                                          color: Colors.grey[300], size: 20),
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
      return NgOsHomeVC();

    case "DONATIONS":
      return AllDonations();

    case "USERS":
      return UsersHomeVC();
    case "PUSH NOTIFICATIONS":
      return const PushNotifications();
    case "CHATS":
      return const Chats();
    case "":
      return AdminHomeVC();
  }
}

class PageScreen extends StatelessWidget {
  const PageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
