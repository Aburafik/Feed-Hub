import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthUser {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference chats =
      FirebaseFirestore.instance.collection('questionsAndAnswers');
  addUser(
      {String? fullName,
      String? email,
      String? location,
      String? userId,
      String? contact}) async {
    await users.doc(userId).set(
      {
        "userName": fullName,
        "email": email,
        "location": location,
        "contact": contact
      },
    );
  }

  Future signUpUser(
      {String? emailAddress,
      String? password,
      String? fullName,
      String? location,
      String? contact,
      BuildContext? context}) async {
    startLoading(status: "Signing Up ..");
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailAddress!,
        password: password!,
      )
          .then((value) {
        addUser(
          fullName: fullName,
          email: emailAddress,
          location: location,
          contact: contact,
          userId: value.user!.uid,
        );
        stopLoading();
        Get.toNamed(RouterHelper.dashBoard);
      });
    } on FirebaseAuthException catch (e) {
      stopLoading();
      if (e.code == 'weak-password') {
        showSnackbar(
            messsage: 'The password provided is too weak.', context: context);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        stopLoading();
        showSnackbar(
            messsage: 'The account already exists for that email.',
            context: context);

        print('The account already exists for that email.');
      }
    } on SocketException {
      stopLoading();

      print("nework erro########################");
    } catch (e) {
      stopLoading();
      showSnackbar(
          context: context,
          messsage: "Opps, something went wrong!",
          isError: true);
      print(e);
    }
  }

  ///Sign In User

  signInUser(
      {String? emailAddress, String? password, BuildContext? context}) async {
    startLoading(status: "Signing In");
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress!, password: password!)
          .timeout(
        Duration(seconds: 30),
        onTimeout: () {
          stopLoading();
          return showSnackbar(
              context: context,
              messsage: "Opps, Check your internet connection!",
              isError: true);
        },
      );

      stopLoading();
      Get.offNamed(GetPlatform.isWeb
          ? RouterHelper.webDashBoard
          : RouterHelper.dashBoard);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        stopLoading();

        showSnackbar(
            context: context,
            messsage: 'No user found for that email.',
            isError: true);
      } else if (e.code == 'wrong-password') {
        stopLoading();

        showSnackbar(
            context: context,
            messsage: 'Wrong password provided for that user.',
            isError: true);
        // print('Wrong password provided for that user.');
      }
    } on SocketException catch (_) {
      stopLoading();
      showSnackbar(
          context: context,
          messsage: "Opps, Check your internet connection!",
          isError: true);
      print("nework erro########################");
    } on TimeoutException catch (e) {
      stopLoading();
      showSnackbar(
          context: context,
          messsage: "Opps, Check your internet connection!",
          isError: true);
    } catch (e) {
      stopLoading();
      showSnackbar(
          context: context,
          messsage: "Opps, something went wrong!",
          isError: true);
      print(e);
    }
  }

  logOut() async {
    startLoading();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    Get.offNamed(RouterHelper.signIn);
    stopLoading();
    pref.remove('user');

    // Future.delayed(Duration(seconds: 3), () async {
    //   pref.remove('user');

    // });
  }

  Future sendQuestion(
      {String? senderEmail,
      String? senderName,
      String? senderContact,
      String? question,
      String? senderImageUrl,
      BuildContext? context,
      String? id}) async {
    return chats.add({
      'full_name': senderName,
      'email': senderEmail,
      'contact': senderContact,
      'question': question,
      "image_url": senderImageUrl,
      "senderId": id,
      'created_at': Timestamp.now().millisecondsSinceEpoch,
    });
  }

  static String constructFCMPayload({String? message, String? title}) {
    return jsonEncode({
      'to': "/topics/feedHub",
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
      },
      'notification': {'title': title, 'body': message},
    });
  }

  static Future<void> sendPushMessage({String? message, String? title}) async {
    // if (token == null) {
    //   print('Unable to send FCM message, no token exists.');
    //   return;
    // }

    try {
      String serverKey =
          "AAAAcIoHjhk:APA91bHJvsYzXghQbBUSdDgBwJORY9NRoKEZoqx7yx29drG6H-x2Sa92Gu7YI24_ArWOlHSVRGqJRywPkNAjaAbqVEqKCBo-Qmy0iL-BPfr7V2iavIUuFAC0w5zYb0NDYUzMSA9wZRcm";
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$serverKey'
        },
        body: constructFCMPayload(title: title, message: message),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  ////UPDATE USER
  static String constructFCMPayloadForAparticularUser({String? id}) {
    return jsonEncode({
      'to': "/topics/$id",
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
      },
      'notification': {
        'title': 'Hi!',
        'body': 'Your order request has been approved!',
      },
    });
  }

  static Future<void> sendPushMessageToUser({String? id}) async {
    // if (token == null) {
    //   print('Unable to send FCM message, no token exists.');
    //   return;
    // }

    try {
      String serverKey =
          "AAAAcIoHjhk:APA91bHJvsYzXghQbBUSdDgBwJORY9NRoKEZoqx7yx29drG6H-x2Sa92Gu7YI24_ArWOlHSVRGqJRywPkNAjaAbqVEqKCBo-Qmy0iL-BPfr7V2iavIUuFAC0w5zYb0NDYUzMSA9wZRcm";
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$serverKey'
        },
        body: constructFCMPayloadForAparticularUser(id: id),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}
