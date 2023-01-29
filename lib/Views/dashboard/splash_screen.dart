import 'dart:async';

import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/images.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => Get.offNamed(RouterHelper.signIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(Images.logo),
      ),
    );
  }
}
