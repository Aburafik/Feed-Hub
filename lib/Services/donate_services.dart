import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Controllers/notifications_controller.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonationServices {
  CollectionReference userdonations =
      FirebaseFirestore.instance.collection('UserDonations');
  CollectionReference alldonations =
      FirebaseFirestore.instance.collection('AllDonations');
  CollectionReference organizations =
      FirebaseFirestore.instance.collection('organizations');
  CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');
  String userId = FirebaseAuth.instance.currentUser!.uid;
  Future donateItem({
    String? dishName,
    String? foodQuantity,
    String? pickUpDate,
    String? pickUpLocation,
    String? furtherInfor,
    String? name,
    BuildContext? context,
  }) async {
    startLoading(status: "sending request");
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userProfile = pref.getString('user');
    Map<String, dynamic> user = json.decode(userProfile!);
    print(user);
    try {
      await alldonations.add({
        "dishName": dishName,
        "foodQuantity": foodQuantity,
        "pickUpDate": pickUpDate,
        "pickUpLocation": pickUpLocation,
        "furtherInfor": furtherInfor,
        "senderName": user["userName"],
        "senderLocation": user['location'],
        "senderContact": user["contact"],
        "name": name,
        "userId": userId,
        "status": false,
        "created": Timestamp.now().millisecondsSinceEpoch
      });
      stopLoading();
      donateSuccessMessage(context: context);

      Future.delayed(const Duration(seconds: 5), () {
        NotificationsController.showNotification(
          body: "Your donation was recieved successfully",
          title: "Hi ${user["userName"]}",
        );
      });

      // Get.back();
    } catch (e) {
      stopLoading();
      print(e);
      print(user);

      showSnackbar(
          messsage: "Oppps something went wrong",
          isError: true,
          context: context);
    }
  }

  uploadNewNGO({
    String? organizationName,
    String? organizationDescription,
    String? location,
    String? image,
    BuildContext? context,
  }) async {
    try {
      await organizations.add({
        "organizationName": organizationName,
        "organizationDescription": organizationDescription,
        "location": location,
        "image": image,
        "created": Timestamp.now().millisecondsSinceEpoch
      }).then((value) {
        stopLoading();

        Get.back();
      });
      showSnackbar(
          messsage: "Organization uploaded successfully", context: context!);
    } catch (e) {
      stopLoading();
      showSnackbar(
          messsage: "Oppps something went wrong",
          isError: true,
          context: context!);
    }
  }

  sendPushNotication({
    String? title,
    String? body,
    BuildContext? context,
  }) async {
    startLoading();

    try {
      await notifications.add({
        "title": title,
        "body": body,
        "created": Timestamp.now().millisecondsSinceEpoch
      }).then((value) {
        stopLoading();

        Get.back();
      });
      showSnackbar(messsage: "Message sent successfully", context: context!);
    } catch (e) {
      stopLoading();
      showSnackbar(
          messsage: "Oppps something went wrong",
          isError: true,
          context: context!);
    }
  }

  getNotification({String? title, String? body}) async {
    await notifications.add({"title": title, "body": body});
  }
}
