import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Views/dashboard/dash_board_view.dart';
import 'package:feed_hub/Views/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backGroundColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.primaryColor,
            elevation: .5,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: AppColors.whiteColor,
            ),
            iconTheme: IconThemeData(color: AppColors.whiteColor)),
      ),
      home: const DashBoardView(),
    );
  }
}
