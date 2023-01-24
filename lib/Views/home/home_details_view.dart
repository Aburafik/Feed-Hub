import 'package:feed_hub/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:readmore/readmore.dart';

class HomeDetailsView extends StatelessWidget {
  const HomeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.bodyText1!;
    const expandedStyle = TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryLightColor);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NGoDetailsImageHolderComponent(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mothers Care Foundation",
                  style: style.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  "Child Welfare Home",
                  style: style,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: SizedBox(
                    // color: Colors.red,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ngoStatistics(leading: "20+", trailing: "Campaigns"),
                        vDivider(),
                        ngoStatistics(leading: "20+", trailing: "Total Feeds"),
                        vDivider(),
                        ngoStatistics(leading: "4.5", trailing: "Reviews"),
                      ],
                    ),
                  ),
                ),
                Text(
                  "About NGO",
                  style: style.copyWith(fontSize: 20),
                ),
                const ReadMoreText(
                    'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Show less',
                    moreStyle: expandedStyle,
                    lessStyle: expandedStyle),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 12,
                    child: ListView.builder(
                      itemCount: 6,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) => const NgoImagesCard()),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    color: AppColors.primaryColor,
                    onPressed: () {},
                    child: const Text("DONATE"),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  VerticalDivider vDivider() {
    return const VerticalDivider(
      width: 20,
      color: Colors.black,
    );
  }

  Column ngoStatistics({String? leading, String? trailing}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(leading!),
        Text(trailing!),
      ],
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
      margin: EdgeInsets.only(right: 10),
      height: 80,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
    );
  }
}

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
