import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileVC extends StatelessWidget {
  ProfileVC({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
   String userId = FirebaseAuth.instance.currentUser!.uid;
  //  Stream<DocumentSnapshot> userProfileStream =
  //     FirebaseFirestore.instance.collection('users').doc(userId).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final userInfor = snapshot.data!.data() as Map<String, dynamic>;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Align(
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
                          SizedBox(height: 10),
                          Text(userInfor['userName']),
                        ],
                      ),
                      headerTitle(context: context, title: "User Name"),
                      FormFieldComponent(
                        label: userInfor['userName'],
                        controller: nameController,
                        validateForm: false,
                      ),
                      headerTitle(context: context, title: "User Email"),
                      FormFieldComponent(
                        label: userInfor['email'],
                        controller: emailController,
                        validateForm: false,
                      ),
                      headerTitle(context: context, title: "Mobile Number"),
                      FormFieldComponent(
                        label: userInfor['contact'],
                        controller: mobileNumberController,
                        validateForm: false,
                      ),
                      headerTitle(context: context, title: "Location"),
                      FormFieldComponent(
                        label: userInfor['location'],
                        controller: locationController,
                        validateForm: false,
                      ),
                      const SizedBox(height: 20),
                      CommonButton(
                        onPressed: () {},
                        buttonText: "UPDATE",
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          )),
    );
  }
}
