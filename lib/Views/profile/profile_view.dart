import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:flutter/material.dart';

class ProfileVC extends StatelessWidget {
  ProfileVC({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Align(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.lightGreyColor,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  Text("Citizen Raf"),
                ],
              ),
              headerTitle(context: context, title: "User Name"),
              FormFieldComponent(
                label: "Aburaf",
                controller: nameController,
                validateForm: false,
              ),
              headerTitle(context: context, title: "User Email"),
              FormFieldComponent(
                label: "Aburaf",
                controller: nameController,
                validateForm: false,
              ),
              headerTitle(context: context, title: "Mobile Number"),
              FormFieldComponent(
                label: "05522..........",
                controller: nameController,
                validateForm: false,
              ),
              headerTitle(context: context, title: "Location"),
              FormFieldComponent(
                label: "05522..........",
                controller: nameController,
                validateForm: false,
              ),
              SizedBox(height: 20),
              CommonButton(
                onPressed: () {},
                buttonText: "UPDATE",
              )
            ],
          ),
        ),
      ),
    );
  }
}
