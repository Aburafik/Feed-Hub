import 'package:feed_hub/Utils/colors.dart';
import 'package:flutter/material.dart';

class FormFieldComponent extends StatelessWidget {
  const FormFieldComponent(
      {Key? key,
      this.controller,
      this.label,
      this.errorMessage,
      this.validateForm = true,
      this.maxLines = 1})
      : super(
          key: key,
        );

  final TextEditingController? controller;
  final String? label;
  final String? errorMessage;
  final bool? validateForm;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
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
              const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          label: Text(
            label!,
          ),
          labelStyle: TextStyle(fontSize: 12),
          filled: true,
          fillColor: AppColors.lightGreyColor,
          border: InputBorder.none),
    );
  }
}
