import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Services/auth_service.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SignUP extends StatelessWidget {
  SignUP({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthUser authUser = AuthUser();
  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.bodyText1!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              color: AppColors.primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 25),
                          ),
                  const SizedBox(height: 20),
                  FormFieldComponent(
                    label: "Full Name",
                    controller: nameController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: FormFieldComponent(
                      label: "Email",
                      controller: emailController,
                    ),
                  ),
                  FormFieldComponent(
                    label: "Location",
                    controller: locationController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: FormFieldComponent(
                      label: "Phone Number",
                      controller: phoneController,
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: FormFieldComponent(
                      label: "Password",
                      controller: passwordController,
                    ),
                  ),
                  const SizedBox(height: 40),
                  CommonButton(
                    onPressed: () async {
                      authUser.signUpUser(
                          fullName: nameController.text,
                          emailAddress: emailController.text,
                          location: locationController.text,
                          contact: phoneController.text,
                          password: passwordController.text,
                          context: context);
                    },
                    buttonText: "Sign Up",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Already havd an account?"),
                        GestureDetector(
                          onTap: () => Get.toNamed(RouterHelper.signIn),
                          child: Text(
                            "Sign In",
                            style:
                                style.copyWith(color: AppColors.primaryColor),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
