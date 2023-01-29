import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  String userId = FirebaseAuth.instance.currentUser!.uid;
  Future donateItem({
    String? dishName,
    String? foodQuantity,
    String? pickUpDate,
    String? pickUpLocation,
    String? furtherInfor,
    BuildContext? context,
  }) async {
    try {
      startLoading(status: "sending request");
      SharedPreferences pref = await SharedPreferences.getInstance();
      final userProfile = pref.getString('user');
      Map<String, dynamic> user = json.decode(userProfile!);
      await alldonations.add({
        "dishName": dishName,
        "foodQuantity": foodQuantity,
        "pickUpDate": pickUpDate,
        "pickUpLocation": pickUpLocation,
        "furtherInfor": furtherInfor,
        "senderName": user["userName"],
        "senderLocation": user['location'],
        "senderContact": user["contact"],
        "userId": userId,
        "status": false
      });
      stopLoading();
      donateSuccessMessage(context: context);
      // Get.back();
    } catch (e) {
      stopLoading();
      print(e);
      showSnackbar(messsage: "Oppps something went wrong", isError: true);
    }
  }

  uploadNewNGO(
      {String? organizationName,
      String? organizationDescription,
      String? location,
      BuildContext? context}) async {
    startLoading();

    try {
      await organizations.add({
        "organizationName": organizationName,
        "organizationDescription": organizationDescription,
        "location": location
      }).then((value) {
        stopLoading();

        Get.back();
      });
      showSnackbar(
          messsage: "Organization uploaded successfully", context: context!);
    } catch (e) {
      stopLoading();
      print(e);
      showSnackbar(
          messsage: "Oppps something went wrong",
          isError: true,
          context: context!);
    }
  }
}
