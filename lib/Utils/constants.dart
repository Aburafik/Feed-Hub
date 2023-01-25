import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class NGoDetailsImageHolderComponent extends StatelessWidget {
  const NGoDetailsImageHolderComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Stack(children: [
        // Image.asset(Images.img)

        Container(
          color: Colors.red,
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
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        title!,
        style: Theme.of(context!).textTheme.bodyText1!.copyWith(fontSize: 18),
      ),
    );
  }