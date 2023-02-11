import 'package:feed_hub/Admin/admin_login.dart';
import 'package:feed_hub/Views/authentication/sign_in.dart';
import 'package:feed_hub/Views/authentication/sign_up.dart';
import 'package:feed_hub/Views/dashboard/dash_board_view.dart';
import 'package:feed_hub/Views/donate/donate_form.dart';
import 'package:feed_hub/Views/home/home_details_view.dart';
import 'package:feed_hub/Views/home/ngos_details_view.dart';
import 'package:feed_hub/main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouterHelper {
  static const String home = "/home";
  static const String dashBoard = "/dashBoard";
  static const String donateFormView = "/donateFormView";
  static const String homeDetailsView = "/homeDetailsView";
  static const String allNgoListView = "/allNgoListView";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String webDashBoard = "/webDashBoard";
  static const String adminLogin = "/adminLogin";
  static const String page = "/page";

  static List<GetPage> router = [
    GetPage(name: dashBoard, page: () => const DashBoardView()),
    GetPage(name: homeDetailsView, page: () => const HomeDetailsView()),
    GetPage(name: donateFormView, page: () => const DonateFormVC()),
    GetPage(name: allNgoListView, page: () => const AllOrganizationsListVC()),
    GetPage(name: signUp, page: () => SignUP()),
    GetPage(name: signIn, page: () => SignIn()),
    GetPage(name: webDashBoard, page: () => const WebDashboardVC()),
    GetPage(name: adminLogin, page: () => AdminLogin()),
    GetPage(name: page, page: () => PageScreen()),
  ];
}
