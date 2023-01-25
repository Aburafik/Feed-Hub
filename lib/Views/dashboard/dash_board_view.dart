import 'package:feed_hub/Utils/colors.dart';
import 'package:feed_hub/Views/donate/donation_history.dart';
import 'package:feed_hub/Views/home/home.dart';
import 'package:feed_hub/Views/profile/profile_view.dart';
import 'package:flutter/material.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({
    super.key,
  });
  // final int? pageIndex;
  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  int _pageIndex = 0;
  PageController? _pageController;

  List<Widget>? screens;
  @override
  void initState() {
    _pageController = PageController(initialPage: _pageIndex);

    screens = [
      const HomeVC(),
      const DonationHistoryVC(),
      ProfileVC(),
      const Center(
        child: Text("Home"),
      ),
    ];
    super.initState();
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("FEED Hub"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],
      ),
      body: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: screens!.length,
          itemBuilder: ((context, index) => screens![index])),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _pageIndex,
        onTap: _setPage,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "History", icon: Icon(Icons.list)),
          BottomNavigationBarItem(
              label: "Profile", icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: "Chats", icon: Icon(Icons.chat)),
        ],
      ),
    );
  }
}
