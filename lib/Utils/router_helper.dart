import 'package:feed_hub/Views/dashboard/dash_board_view.dart';
import 'package:feed_hub/Views/donate/donate_form.dart';
import 'package:feed_hub/Views/home/home_details_view.dart';
import 'package:feed_hub/Views/home/ngos_details_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouterHelper {
  static const String initialRoute = "/slash-screen";
  static const String home = "/home";
  static const String dashBoard = "/dashBoard";
  static const String donateFormView = "/donateFormView";
  static const String homeDetailsView = "/homeDetailsView";
  static const String allNgoListView = "/allNgoListView";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";

  static List<GetPage> router = [
    GetPage(name: dashBoard, page: () => const DashBoardView()),
    GetPage(name: homeDetailsView, page: () => const HomeDetailsView()),
    GetPage(name: donateFormView, page: () => const DonateFormVC()),
    GetPage(name: allNgoListView, page: () => const AllOrganizationsListVC()),
  ];
}
