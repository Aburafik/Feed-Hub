import 'package:feed_hub/Components/common_button.dart';
import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/constants.dart';
import 'package:feed_hub/Utils/router_helper.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const NGoDetailsImageHolderComponent(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "  Get.parameters['location']!.toString(),",
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
                          ngoStatistics(
                              leading: "20+", trailing: "Total Feeds"),
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
                      'Flutter is Google’s mobile UI open jehbfghjbghrthrththjtnhtrnhjrtngjnjgnjrfgrturbghtgbhrbghrbghbrtbghrtbghrtgrtuguhrtbreghjbrhjbghjefbhjbfehgfhjefbgfhjebghbehjgbfbfdgedsource framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
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
                        itemBuilder: ((context, index) =>
                            const NgoImagesCard()),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CommonButton(
                          buttonText: "Donate",
                          onPressed: () =>
                              Get.toNamed(RouterHelper.donateFormView),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
