import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Services/auth_service.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatelessWidget {
  AdminLogin({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthUser _authUser = AuthUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      "FEED HUB Admin",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FormFieldComponent(
                    label: "email",
                    controller: emailController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: FormFieldComponent(
                      label: "email",
                      controller: passwordController,
                    ),
                  ),
                  CommonButton(
                    onPressed: () async {
                      _authUser.signInUser(
                          emailAddress: emailController.text,
                          password: passwordController.text,
                          context: context);
                    },
                    buttonText: "Log In",
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
