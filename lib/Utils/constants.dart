import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/images.dart';
import 'package:feed_hub/Utils/router_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class NGoDetailsImageHolderComponent extends StatelessWidget {
  const NGoDetailsImageHolderComponent({Key? key, this.imageUrl})
      : super(key: key);
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(imageUrl!), fit: BoxFit.fill),
          ),
        ),
        SafeArea(
          child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back_rounded)),
        ),
      ]),
    );
  }
}

class NgoImagesCard extends StatelessWidget {
  const NgoImagesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 80,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[300],
      ),
    );
  }
}

Padding headerTitle({BuildContext? context, String? title}) {
  return Padding(
    padding: const EdgeInsets.only(top: 25,bottom: 10),
    child: Text(
      title!,
      style: Theme.of(context!).textTheme.bodyLarge!.copyWith(fontSize: 14),
    ),
  );
}

startLoading({String? status}) {
  return EasyLoading.show(
    status: status,
    maskType: EasyLoadingMaskType.black,
  );
}

stopLoading() {
  return EasyLoading.dismiss();
}

showSnackbar({String? messsage, BuildContext? context, bool isError = false}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      // behavior: SnackBarBehavior.,
      // width: GetPlatform.isDesktop?100:null,
      content: Text(messsage!),
      backgroundColor: isError ? Colors.red : AppColors.primaryColor,
    ),
  );
}

donateSuccessMessage({BuildContext? context}) {
  Get.defaultDialog(
      backgroundColor: AppColors.whiteColor.withOpacity(0.7),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      title: "",
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primaryColor,
              child: Icon(Icons.check, color: AppColors.whiteColor, size: 50),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                "Success",
                style: Theme.of(context!)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 20),
              ),
            ),
            Text(
              "Your donation request was sent successfully",
              style:
                  Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      confirm: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CommonButton(
            buttonText: "Done",
            onPressed: () {
              Get.toNamed(RouterHelper.dashBoard);
            }),
      ));
}

Center appLogo() {
  return const Center(
    child: CircleAvatar(
      radius: 80,
      backgroundColor: AppColors.lightGreyColor,
      backgroundImage: AssetImage(Images.logo),
    ),
  );
}
