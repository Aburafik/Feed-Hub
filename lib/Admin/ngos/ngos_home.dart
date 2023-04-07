import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Components/form_field.dart';
import 'package:feed_hub/Controllers/getData_controller.dart';
import 'package:feed_hub/Services/auth_service.dart';
import 'package:feed_hub/Services/donate_services.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/instance_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;

class NgOsHomeVC extends StatelessWidget {
  NgOsHomeVC({super.key});
  final Stream<QuerySnapshot> organizations =
      FirebaseFirestore.instance.collection('organizations').snapshots();
  final DataController dataController = Get.find<DataController>();
  @override
  Widget build(BuildContext context) {
    TextStyle style =
        Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 13);
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
              child: SingleChildScrollView(
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
                          .copyWith(color: Color.fromARGB(255, 201, 202, 206)),
                      headingRowHeight: 30,
                      horizontalMargin: 20,
                      headingRowColor: MaterialStateProperty.all(
                          AppColors.adminPrimaryColor),
                      columns: const [
                        DataColumn(label: Text("Image")),
                        DataColumn(
                            label: Expanded(child: Text("Organization Name"))),
                        DataColumn(
                            label: Text(
                          "Organization Description",
                          softWrap: true,
                        )),
                        DataColumn(label: Text("Location")),
                        DataColumn(label: Text("Update")),
                      ],
                      rows: ngos
                          .map((e) => DataRow(cells: [
                                const DataCell(CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "https://media.istockphoto.com/id/619643870/photo/hungry-african-children-asking-for-food-africa.jpg?b=1&s=612x612&w=0&k=20&c=8IQr0y64vuvHGo59LXL1_CtR8cPU-1h5_AA1iV73yZI="),
                                )),
                                DataCell(Text(
                                  e['organizationName'],
                                  style: style,
                                )),
                                DataCell(Text(
                                  e["organizationDescription"],
                                  style: style,
                                )),
                                DataCell(Text(
                                  e["location"],
                                  style: style,
                                )),
                                const DataCell(Icon(FeatherIcons.edit)),
                              ]))
                          .toList());
                } else {
                  return const Expanded(
                    child: Center(
                      child: Text("Loading..............."),
                    ),
                  );
                }
              }),
            ),
          ))
        ],
      ),
    );
  }
}

FirebaseFirestore getPic = FirebaseFirestore.instance;

class AddNewNGoComponent extends StatefulWidget {
  const AddNewNGoComponent({
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
  final TextEditingController tokenController = TextEditingController();

  final TextEditingController organizationLocationController =
      TextEditingController();

  String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';
  String selctFile = '';
  XFile? file;
  Uint8List? selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  String imageUrls = "";

  DonationServices donationServices = DonationServices();

  _selectFile(bool imageFrom) async {
    FilePickerResult? fileResult =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (fileResult != null) {
      selctFile = fileResult.files.first.name;
      setState(() {
        selectedImageInBytes = fileResult.files.first.bytes;
      });
    }
    print(selctFile);
  }

  Future<String> _uploadFile() async {
    String imageUrl = '';
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('images')
          .child('/$selctFile');

      final metadata =
          firabase_storage.SettableMetadata(contentType: 'image/jpeg');

      uploadTask = ref.putData(selectedImageInBytes!, metadata);

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      setState(() {
        imageUrls = imageUrl;
      });
      print(imageUrl);
    } catch (e) {
      print(e);
      print(imageUrl);
    }
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
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
                  label: "Organization Location",
                  controller: organizationLocationController,
                ),
              ),
              // FormFieldComponent(
              //   label: "Token",
              //   controller: tokenController,
              // ),
              // const SizedBox(height: 15),
              FormFieldComponent(
                maxLines: 4,
                label: "Organization Description",
                controller: organizationDescriptionController,
              ),
              const SizedBox(height: 15),
              const Text("Upload Organization Logo"),
              const SizedBox(height: 15),
              UploadImagePlaceHolderComponent(
                uploadType: "Image",
                imageFile: selectedImageInBytes,
                onTap: () {
                  _selectFile(true);
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                child: CommonButton(
                  buttonText: "UPLOAD",
                  onPressed: () async {
                    startLoading();
                    await _uploadFile();

                    await donationServices.uploadNewNGO(
                        context: context,
                        organizationName: organizationNameController.text,
                        organizationDescription:
                            organizationDescriptionController.text,
                        image: imageUrls,
                        location: organizationLocationController.text);
                    await AuthUser.sendPushMessage(
                      title: "Hi",
                      message:
                          'A New organization food request has been uploaded!',
                    );
                  },
                ),
              )
            ],
          ),
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
