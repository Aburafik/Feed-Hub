import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonationServices {
  CollectionReference donations =
      FirebaseFirestore.instance.collection('donations');
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

      await donations.doc(userId).collection("my-donations").add({
        "dishName": dishName,
        "foodQuantity": foodQuantity,
        "pickUpDate": pickUpDate,
        "pickUpLocation": pickUpLocation,
        "furtherInfor": furtherInfor,
        "senderName": user["userName"],
        "senderLocation": user['location'],
        "senderContact": user["contact"],
        "status": false
      });
      stopLoading();
      donateSuccessMessage(context: context);
      // Get.back();
    } catch (e) {
      print(e);
      showSnackbar(messsage: "Oppps something went wrong", isError: true);
    }
  }
}
