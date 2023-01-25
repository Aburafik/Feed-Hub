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
                title: const Text("Donation Name"),
                subtitle: const Text("erjfjnfvjf"),
                leading: const Icon(Icons.check_circle_outline),
                trailing: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    color: const Color(0xffF7682B),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      child: Text("Pending"),
                    )),
              ),
            );
          }),
    );
  }
}
