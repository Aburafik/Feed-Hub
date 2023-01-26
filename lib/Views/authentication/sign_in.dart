// ignore_for_file: use_build_context_synchronously

import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Services/auth_service.dart';
import 'package:feed_hub/Services/user_services.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final UserServices _userServices = UserServices();
  final AuthUser _authUser = AuthUser();
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
                  Text(
                    "Sign In",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 25),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: FormFieldComponent(
                      label: "Email",
                      controller: emailController,
                    ),
                  ),
                  FormFieldComponent(
                    label: "Password",
                    controller: passwordController,
                  ),
                  const SizedBox(height: 40),
                  CommonButton(
                    onPressed: () async {
                      await _authUser.signInUser(
                          emailAddress: emailController.text,
                          password: passwordController.text,
                          context: context);

                      await _userServices.getUser();
                    },
                    buttonText: "Sign In",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Don't have an account?"),
                        GestureDetector(
                          onTap: () => Get.toNamed(RouterHelper.signUp),
                          child: Text(
                            "Sign Up",
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
