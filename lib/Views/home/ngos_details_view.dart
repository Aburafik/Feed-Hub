import 'package:feed_hub/Views/home/home.dart';
import 'package:flutter/material.dart';

class AllOrganizationsListVC extends StatelessWidget {
  const AllOrganizationsListVC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Organizations")),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return const OtherRequestCardComponent();
          }),
    );
  }
}
