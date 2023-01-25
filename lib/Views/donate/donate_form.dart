import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonateFormVC extends StatefulWidget {
  const DonateFormVC({super.key});

  @override
  State<DonateFormVC> createState() => _DonateFormVCState();
}

class _DonateFormVCState extends State<DonateFormVC> {
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController foodQualityController = TextEditingController();
  final TextEditingController pickUpDateController = TextEditingController();
  final TextEditingController pickUpLocationController =
      TextEditingController();
  final TextEditingController furtherDirectionsController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Donate",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: Text(
                    "Food Details",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColors.primaryColor, fontSize: 20),
                  ),
                ),
                headerTitle(title: "Dish Name", context: context),
                FormFieldComponent(
                  errorMessage: "Food Name",
                  label: "eg. Rice",
                  controller: foodNameController,
                ),
                headerTitle(title: "Food Quantity", context: context),
                FormFieldComponent(
                    errorMessage: "Food Quality",
                    label: "eg. 50 people",
                    controller: foodQualityController),
                headerTitle(title: "Pickup Date", context: context),
                FormFieldComponent(
                  errorMessage: "PickUp Date",
                  label: "12/2.2022",
                  controller: pickUpDateController,
                ),
                headerTitle(title: "Pickup location", context: context),
                FormFieldComponent(
                  errorMessage: "PickUp Location",
                  label: "12/2.2022",
                  controller: pickUpLocationController,
                ),
                headerTitle(
                    title: "Further Direction(Optional)", context: context),
                FormFieldComponent(
                  validateForm: false,
                  errorMessage: "",
                  label: "Message",
                  controller: furtherDirectionsController,
                ),
                const SizedBox(height: 30),
                CommonButton(
                  buttonText: "Submit",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Get.defaultDialog(
                          backgroundColor:
                              AppColors.whiteColor.withOpacity(0.7),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          title: "",
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(Icons.check,
                                      color: AppColors.whiteColor, size: 50),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    "Success",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(fontSize: 20),
                                  ),
                                ),
                                Text(
                                  "Your donation request was sent successfully",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                        fontSize: 16
                                      ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          confirm: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: CommonButton(
                                buttonText: "Done",
                                onPressed: () {
                                  Get;
                                }),
                          ));
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

 
}
