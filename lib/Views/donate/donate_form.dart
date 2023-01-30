import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Controllers/organizations_controller.dart';
import 'package:feed_hub/Services/donate_services.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

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
  final DonationServices _donateItem = DonationServices();
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _donateItem.donateItem(
                          context: context,
                          dishName: foodNameController.text,
                          foodQuantity: foodQualityController.text,
                          pickUpDate: pickUpDateController.text,
                          pickUpLocation: pickUpLocationController.text,
                          furtherInfor: furtherDirectionsController.text,
                        );
                        Get.put(OrganizationsController());
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
