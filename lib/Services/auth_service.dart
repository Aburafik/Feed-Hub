import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AuthUser {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
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
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        stopLoading();
        showSnackbar(
            messsage: 'The account already exists for that email.',
            context: context);

        // print('The account already exists for that email.');
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress!, password: password!);

      stopLoading();
      Get.toNamed(RouterHelper.dashBoard);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        stopLoading();

        // print('No user found for that email.');

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
    } catch (e) {
      stopLoading();
      showSnackbar(
          context: context,
          messsage: "Opps, something went wrong!",
          isError: true);
      print(e);
    }
  }
}
