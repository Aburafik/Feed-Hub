import 'package:feed_hub/Utils/colors.dart';
import 'package:flutter/material.dart';

class DonationHistoryVC extends StatelessWidget {
  const DonationHistoryVC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text("Donation Name"),
                leading: Icon(Icons.check_circle_outline),
                trailing: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: AppColors.primaryLightColor,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text("Pending"),
                    )),
              ),
            );
          }),
    );
  }
}
