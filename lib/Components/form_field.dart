 import 'package:feed_hub/Utils/colors.dart';
import 'package:flutter/material.dart';

class FormFieldComponent extends StatelessWidget {
  const FormFieldComponent(
      {Key? key,
      this.controller,
      this.label,
      this.errorMessage,
      this.validateForm = true})
      : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? errorMessage;
  final bool? validateForm;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validateForm!
          ? (value) {
              if (value!.isEmpty) {
                return "$errorMessage can't be empty";
              }
              return null;
            }
          : null,
      controller: controller,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          label: Text(
            label!,
          ),
          filled: true,
          fillColor: AppColors.lightGreyColor,
          border: InputBorder.none),
    );
  }
}
