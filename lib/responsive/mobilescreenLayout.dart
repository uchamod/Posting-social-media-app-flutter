import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/pages/addpostpage.dart';
import 'package:instagram_clone/pages/homepage.dart';
import 'package:instagram_clone/pages/notifiypage.dart';
import 'package:instagram_clone/pages/profilepage.dart';
import 'package:instagram_clone/pages/serchpage.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:provider/provider.dart';

class MobileScreenlayout extends StatefulWidget {
  const MobileScreenlayout({super.key});

  @override
  State<MobileScreenlayout> createState() => _MobileScreenlayoutState();
}

class _MobileScreenlayoutState extends State<MobileScreenlayout> {
  PageController _pageController = PageController();
  int _page = 0;
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void pageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  void onIconTap(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    //   UserProvider userProvider = UserProvider();
    UserModel user = Provider.of<UserProvider>(context).getCurrentUser;
    Icon bottomNavIcon(IconData icon, int page) {
      return Icon(
        icon,
        size: _page == page ? 35 : 30,
        color: _page == page ? ternerycolor : primaryColor,
      );
    }

    return Scaffold(
        body: PageView(
          controller: _pageController,
           pageSnapping: true,
          onPageChanged: pageChange,
          scrollDirection: Axis.horizontal,
          children: const [
            Homepage(),
            SerchPage(),
            AddPostPage(),
            Notifiypage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: mobileSearchColor,
          onTap: onIconTap,
          currentIndex: _page,
          items: [
            BottomNavigationBarItem(
              icon: bottomNavIcon(Icons.home, 0),
            ),
            BottomNavigationBarItem(
              icon: bottomNavIcon(Icons.search, 1),
            ),
            BottomNavigationBarItem(
              icon: bottomNavIcon(Icons.add_circle, 2),
            ),
            BottomNavigationBarItem(
              icon: bottomNavIcon(Icons.notifications, 3),
            ),
            BottomNavigationBarItem(
              icon: bottomNavIcon(Icons.person, 4),
            ),
          ],
        ));
  }
}
 