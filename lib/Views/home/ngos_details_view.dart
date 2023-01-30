import 'package:feed_hub/Views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllOrganizationsListVC extends StatelessWidget {
  const AllOrganizationsListVC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Organizations")),
      body: ListView.builder(
          itemCount: Get.arguments.length,
          itemBuilder: (context, index) {
            return OtherRequestCardComponent(
              organizations: Get.arguments[index],
            );
          }),
    );
  }
}
