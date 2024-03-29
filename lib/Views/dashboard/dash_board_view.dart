import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:feed_hub/Services/auth_service.dart';
import 'package:feed_hub/Services/donate_services.dart';
import 'package:feed_hub/Services/user_services.dart';
import 'package:feed_hub/Views/chats/chats.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Views/donate/donation_history.dart';
import 'package:feed_hub/Views/home/home.dart';
import 'package:feed_hub/Views/profile/profile_view.dart';
import 'package:feed_hub/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({
    super.key,
  });
  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int _pageIndex = 0;
  PageController? _pageController;
  final DonationServices donationServices = DonationServices();
  final UserServices _userServices = UserServices();
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Widget>? screens;
  @override
  void initState() {
    _pageController = PageController(initialPage: _pageIndex);

    screens = [
      HomeVC(),
      DonationHistoryVC(),
      const Chats(),
      ProfileVC(),
    ];
    var iosInitialization = const DarwinInitializationSettings();
    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      iOS: iosInitialization,
      android: initialzationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage? message) {
        RemoteNotification notification = message!.notification!;
        AndroidNotification android = message.notification!.android!;
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              color: Colors.blue,
              icon: "@mipmap/ic_launcher",
            ),
          ),
        );

        const DarwinNotificationDetails();
        print(message.notification!.title);
        donationServices.getNotification(
            title: notification.title, body: notification.body);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      if (message != null) {}
      Navigator.pushNamed(
        context,
        "/notification",
      );
    });
    getToken();
    _userServices.getUser();
    super.initState();
  }

  String? token;
  getToken() async {
    await FirebaseMessaging.instance.subscribeToTopic("feedHub");
    await FirebaseMessaging.instance
        .subscribeToTopic(auth.currentUser!.uid.toString());

    token = await FirebaseMessaging.instance.getToken();
    print("###########FCM-TOKEN $token");
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerComponent(),
      appBar: AppBar(
        title: const Text("FEED Hub"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications,size: 20,),
          )
        ],
      ),
      body: ConnectivityWidgetWrapper(
        message: "Opps! Lost internet connection",
        child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            itemCount: screens!.length,
            itemBuilder: ((context, index) => screens![index])),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _pageIndex,
        onTap: _setPage,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(FeatherIcons.home,size: 20,)),
          BottomNavigationBarItem(
              label: "History", icon: Icon(FeatherIcons.list,size: 20,)),
          BottomNavigationBarItem(
              label: "Chats", icon: Icon(FeatherIcons.messageSquare,size: 20,)),
          BottomNavigationBarItem(
              label: "Profile", icon: Icon(FeatherIcons.user,size: 20,)),
        ],
      ),
    );
  }
}

class AppDrawerComponent extends StatelessWidget {
  AppDrawerComponent({
    Key? key,
  }) : super(key: key);
  final AuthUser _authUser = AuthUser();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!.copyWith();
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(FeatherIcons.user),
            title: Text(
              "Profile",
              style: textStyle,
            ),
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: const Icon(FeatherIcons.clock),
              title: Text(
                "Donation Overview",
                style: textStyle,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(FeatherIcons.bookmark),
            title: Text(
              "About us",
              style: textStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: const Icon(FeatherIcons.info),
              title: Text(
                "Help",
                style: textStyle,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(FeatherIcons.share2),
            title: Text("Share", style: textStyle),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: const Icon(FeatherIcons.activity),
              title: Text(
                "Terms and Conditions",
                style: textStyle,
              ),
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () async {
              await _authUser.logOut();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Logout",
                    style: textStyle.copyWith(color: Colors.red,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
