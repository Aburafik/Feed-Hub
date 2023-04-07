import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Services/auth_service.dart';
import 'package:feed_hub/Services/donate_services.dart';
import 'package:flutter/material.dart';

class PushNotifications extends StatelessWidget {
  PushNotifications({super.key});
  DonationServices donationServices = DonationServices();
  // String? messageTitle;
  // String? messageBody;
  TextEditingController messageTitleController = TextEditingController();
  TextEditingController messageBodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text("Send BroadCast Message"),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormFieldComponent(
                    controller: messageTitleController,
                    label: "Message Title",
                    errorMessage: "Title",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: FormFieldComponent(
                      controller: messageBodyController,
                      label: "Message Body",
                      maxLines: 2,
                      errorMessage: "Message body",
                    ),
                  ),
                  CommonButton(
                    buttonText: "Send Message",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await donationServices.sendPushNotication(
                            title: messageTitleController.text.toString(),
                            body: messageBodyController.text.toString(),context: context);
                        await AuthUser.sendPushMessage(
                          title: messageTitleController.text.toString(),
                          message: messageBodyController.text.toString(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
