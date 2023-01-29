import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Controllers/getData_controller.dart';
import 'package:feed_hub/Services/donate_services.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';

class NgOsHomeVC extends StatelessWidget {
  NgOsHomeVC({super.key});
  final Stream<QuerySnapshot> organizations =
      FirebaseFirestore.instance.collection('organizations').snapshots();
  final DataController dataController = Get.find<DataController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("NGOs",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                GestureDetector(
                  child: Text(
                    "Add NGO",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                        decoration: TextDecoration.underline, fontSize: 16),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: ((context) => AddNewNGoComponent()),
                    );
                  },
                )
              ],
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: organizations,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final ngos = snapshot.data!.docs.reversed;
                dataController.getAllNGOs(ngos.length);
                return DataTable(
                    dataTextStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                    headingTextStyle: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: const Color(0xff747889)),
                    headingRowHeight: 30,
                    horizontalMargin: 20,
                    headingRowColor:
                        MaterialStateProperty.all(AppColors.adminPrimaryColor),
                    columns: const [
                      DataColumn(label: Text("Image")),

                      DataColumn(
                          label: Expanded(child: Text("Organization Name"))),
                      DataColumn(
                          label: Text(
                        "Organization Description",
                        softWrap: true,
                      )),
                      DataColumn(label: Text("User Location")),
                      DataColumn(label: Text("Update")),
                      // DataColumn(label: Text("Donation Details")),
                    ],
                    rows: ngos
                        .map((e) => DataRow(cells: [
                              DataCell(CircleAvatar(
                                  // radius: 40,
                                  )),
                              DataCell(Text(e['organizationName'])),
                              DataCell(Text(e["organizationDescription"])),
                              DataCell(Text(e["location"])),
                              DataCell(Icon(FeatherIcons.edit)),
                            ]))
                        .toList());
              } else {
                return const Expanded(
                  child: Center(
                    child: Text("No Data"),
                  ),
                );
              }
            }),
          ))
        ],
      ),
    );
  }
}

class AddNewNGoComponent extends StatefulWidget {
  AddNewNGoComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewNGoComponent> createState() => _AddNewNGoComponentState();
}

class _AddNewNGoComponentState extends State<AddNewNGoComponent> {
  final TextEditingController organizationNameController =
      TextEditingController();

  final TextEditingController organizationDescriptionController =
      TextEditingController();

  final TextEditingController organizationLocationController =
      TextEditingController();
  File? imageFile;
  dynamic imageForSendToAPI;
  chooseImage() async {
    final temp = (await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 80));
    imageForSendToAPI = await temp!.readAsBytes();
    setState(() {});

    // print(imageForSendToAPI.toString());
    // XFile? pickedFile = await ImagePicker().pickImage(
    //   source: ImageSource.gallery,
    // );
    // setState(() {
    //   imageFile = File(pickedFile!.path);
    // });
    // print(pickedFile!.);
  }

  DonationServices donationServices = DonationServices();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.white.withOpacity(0.9),
      content: SizedBox(
        width: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text("NEW",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            FormFieldComponent(
              label: "Organization Name",
              controller: organizationNameController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: FormFieldComponent(
                maxLines: 4,
                label: "Organization Description",
                controller: organizationDescriptionController,
              ),
            ),
            FormFieldComponent(
              label: "Organization Location",
              controller: organizationLocationController,
            ),
            const SizedBox(height: 15),
            const Text("Upload Organization Logo"),
            const SizedBox(height: 15),
            UploadImagePlaceHolderComponent(
              uploadType: "Image",
              imageFile: imageForSendToAPI,
              onTap: () {
                chooseImage();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
              child: CommonButton(
                buttonText: "UPLOAD",
                onPressed: () async {
                  donationServices.uploadNewNGO(
                      context: context,
                      organizationName: organizationNameController.text,
                      organizationDescription:
                          organizationDescriptionController.text,
                      location: organizationLocationController.text);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UploadImagePlaceHolderComponent extends StatelessWidget {
  const UploadImagePlaceHolderComponent(
      {Key? key, this.uploadType, this.onTap, this.imageFile})
      : super(key: key);

  final String? uploadType;
  final Function()? onTap;
  final dynamic imageFile;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        radius: const Radius.circular(5),
        borderType: BorderType.RRect,
        strokeWidth: .5,
        strokeCap: StrokeCap.round,
        dashPattern: const [10, 3, 10, 3],
        child: Container(
          height: MediaQuery.of(context).size.height / 5,
          width: 200,
          decoration: BoxDecoration(
              image: imageFile != null
                  ? DecorationImage(image: MemoryImage(imageFile!))
                  : null,
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(FeatherIcons.upload, size: 30),
                  const SizedBox(height: 5),
                  Text(uploadType!)
                ],
              ),
            ),
          ),
        ));
  }
}
