import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Utils/images.dart';
import 'package:flutter/material.dart';

class HomeVC extends StatelessWidget {
  const HomeVC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      // drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeBanner(),
              HomeHeadingComponent(
                leading: "Recent NGOs Request",
                onTap: () {},
              ),
              SizedBox(
                height: 230,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const NGosCard();
                    }),
              ),
              HomeHeadingComponent(
                leading: "Others Request",
                onTap: () {},
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const OtherRequestCardComponent();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class OtherRequestCardComponent extends StatelessWidget {
  const OtherRequestCardComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.bodyText1!;

    return Card(
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Card(
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(
                  Images.img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mothers Of Peace",
                  style: style.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.location_on,
                      size: 15,
                      color: Colors.grey,
                    ),
                    Text("Kasoa")
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.yellow,
                    ),
                    Text("4.5")
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HomeHeadingComponent extends StatelessWidget {
  const HomeHeadingComponent({Key? key, this.leading, this.onTap})
      : super(key: key);
  final String? leading;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leading!,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "View All",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}

class NGosCard extends StatelessWidget {
  const NGosCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context).textTheme.bodyText1!;
    return Card(
      child: SizedBox(
        height: 220,
        width: 200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(Images.img),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Feed Hungry Child",
                      style: style.copyWith(fontSize: 15),
                    ),
                    const Text("Child Care Foundation"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Target: 50",
                          style: style,
                        ),
                        Text("65%",
                            style: style.copyWith(
                              color: AppColors.primaryColor,
                            ))
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: AppColors.whiteColor, fontSize: 16);
    return Card(
      margin: EdgeInsets.zero,
      child: Container(
        height: MediaQuery.of(context).size.height / 5.5,
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              AppColors.primaryLightColor,
              AppColors.primaryColor,
            ]),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you have some", style: style),
                Text(
                  "food to donate?",
                  style: style,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Donate Now -->",
                    style: style,
                  ),
                ),
              ],
            ),
            Image.asset(
              Images.food,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
