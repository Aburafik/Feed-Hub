// ignore_for_file: use_build_context_synchronously

import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Services/auth_service.dart';
import 'package:feed_hub/Services/user_services.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:feed_hub/Controllers/organizations_controller.dart';

import 'package:feed_hub/Utils/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final UserServices _userServices = UserServices();

  final AuthUser _authUser = AuthUser();

  OrganizationsController controller = Get.put(OrganizationsController());
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    controller.fetchAllOrganizations();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.bodyText1!;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              color: AppColors.lightGreyColor,
              child: appLogo(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
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
                        errorMessage: "Email",
                        label: "Email",
                        controller: emailController,
                      ),
                    ),
                    FormFieldComponent(
                      errorMessage: "Password",
                      label: "Password",
                      controller: passwordController,
                    ),
                    const SizedBox(height: 40),
                    CommonButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _authUser.signInUser(
                            emailAddress: emailController.text,
                            password: passwordController.text,
                            context: context,
                          );

                          // await _userServices.getUser();
                        }
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
