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

    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: pageChange,
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
                icon: Icon(
              Icons.home,
              size: _page == 0 ? 34 : 30,
              color: _page == 0 ? primaryColor : primaryColor.withOpacity(0.7),
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.search,
              size: _page == 1 ? 34 : 30,
              color: _page == 1 ? primaryColor : primaryColor.withOpacity(0.7),
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.add_circle,
              size: _page == 2 ? 34 : 30,
              color: _page == 2 ? primaryColor : primaryColor.withOpacity(0.7),
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.notifications,
              size: _page == 3 ? 34 : 30,
              color: _page == 3 ? primaryColor : primaryColor.withOpacity(0.7),
            )),
            BottomNavigationBarItem(
                icon: Icon(
              Icons.person,
              size: _page == 4 ? 34 : 30,
              color: _page == 4 ? primaryColor : primaryColor.withOpacity(0.7),
            )),
          ],
        ));
  }
}
 // String username = "";

  // //get current user data as snapshot
  // Future<void> getUserName() async {
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   setState(() {
  //     username = (snapshot.data() as Map<String, dynamic>)["username"];
  //   });
  // }

     // addData() async {
    //   UserProvider userProvider =
    //       Provider.of<UserProvider>(context, listen: true);
    //   await userProvider.refreshUser();
    // }