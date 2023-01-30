import 'dart:convert';

import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feed_hub/Services/auth_service.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final TextEditingController _questionController = TextEditingController();

  final Stream<QuerySnapshot> _questionsAndAnswersStream =
      FirebaseFirestore.instance.collection('questionsAndAnswers').snapshots();
  String? senderName;
  String? senderEmail;
  String? senderContact;

  final AuthUser _authUser = AuthUser();
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final userProfile = pref.getString('user');
    Map<String, dynamic> user = json.decode(userProfile!);
    setState(() {
      senderName = user["userName"];
      senderContact = user['contact'];
      senderEmail = user['email'];
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _questionsAndAnswersStream,
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    return ListView.builder(
                        reverse: true,
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          dynamic data = snapshots.data!.docs[index].data();

                          var dateTime = DateTime.fromMillisecondsSinceEpoch(
                              data['created_at']);

                          var formatDate =
                              DateFormat('k:mm a').format(dateTime).toString();
                          return Bubble(
                            color: data["senderId"] != _auth.currentUser!.uid
                                ? Colors.white
                                : const Color(0xffE1FFC7),
                            radius: const Radius.circular(20),
                            margin: const BubbleEdges.only(top: 10),
                            elevation: 0,
                            alignment:
                                data["senderId"] == _auth.currentUser!.uid
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                            nip: data["senderId"] == _auth.currentUser!.uid
                                ? BubbleNip.rightTop
                                : BubbleNip.leftTop,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.4,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  data["senderId"] != _auth.currentUser!.uid
                                      ? Text(
                                          data['full_name'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(),
                                        )
                                      : Wrap(),
                                  Text(
                                    "${data['question']}",
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      formatDate.toLowerCase(),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return const Text("Loading...");
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: false,
              controller: _questionController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: 'Ask Question...',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: AppColors.whiteColor,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if (_questionController.text.isEmpty) {
                      // showToast(
                      //     msg:
                      //         "Question field can't be empty.Please enter question",
                      //     color: Colors.red);
                    } else {
                      await _authUser.sendQuestion(
                          id: _auth.currentUser!.uid,
                          question: _questionController.text,
                          senderName: senderName,
                          senderEmail: senderEmail,
                          senderContact: senderContact);
                    }
                    _questionController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
