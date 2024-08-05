import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/pages/edit_profile.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/service/authentication.dart';
import 'package:instagram_clone/service/firestore.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userDetails = {};
  var postDetails;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isLoading = false;
  bool isfollowing = false;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  //get user details
  getUserData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.userId)
          .get();
      var postSnap = await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: widget.userId)
          .get();
      userDetails = userSnap.data()!;
      postDetails = postSnap;
      postCount = postSnap.docs.length;
      followingCount = userSnap.data()!["following"].length;
      followersCount = userSnap.data()!["followers"].length;
      //check user currently follow or not
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      List followings = (snapshot.data() as dynamic)["following"];
      if (followings.contains(widget.userId)) {
        isfollowing = true;
      }
      setState(() {});
    } catch (err) {
      print(err.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  //follow user
  void followNewUser() async {
    await FireStoreMethods().followUser(
        FirebaseAuth.instance.currentUser!.uid, widget.userId, context);
  }

  //void edit profile
  void editProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EditProfilePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    UserModel currentUser = Provider.of<UserProvider>(context).getCurrentUser;
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileSearchColor,
              forceMaterialTransparency: true,
              automaticallyImplyLeading: false,
              leading: userDetails["uid"] != currentUser.user
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_backspace_outlined,
                        color: primaryColor,
                        size: 30,
                      ),
                    )
                  : const SizedBox(
                      width: 10,
                    ),
              actions: [
                //log out action
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    userDetails["uid"] == currentUser.user
                        ? TextButton(
                            onPressed: () async {
                              Authentication().singOut();
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Sing Out",
                              style: body.copyWith(fontSize: 14),
                            ),
                          )
                        : const SizedBox(
                            width: 5,
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //user details section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 10)),
                      CircleAvatar(
                        backgroundImage: NetworkImage(userDetails["avatar"]),
                        radius: 70,
                      ),
                      const Padding(padding: EdgeInsets.only(left: 15)),
                      //username | bio | edit/follow
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userDetails["username"],
                            style: title,
                          ),
                          Text(
                            userDetails["bio"],
                            style: hinttext,
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 8)),
                          //edit/follow button
                          userDetails["uid"] == currentUser.user
                              ? GestureDetector(
                                  onTap: editProfile,
                                  child: reusableButton("Edit Profile"))
                              : isfollowing
                                  ? GestureDetector(
                                      onTap: () {
                                        followNewUser();
                                        setState(() {
                                          isfollowing = false;
                                          followersCount--;
                                        });
                                      },
                                      child: reusableButton("UnFollow"))
                                  : GestureDetector(
                                      onTap: () {
                                        followNewUser();
                                        setState(() {
                                          isfollowing = true;
                                          followersCount++;
                                        });
                                      },
                                      child: reusableButton("Follow")),
                        ],
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 25),
                  ),
                  //status section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      statusCol("posts", postCount),
                      statusCol("following", followingCount),
                      statusCol("followers", followersCount),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //get and show posts
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("posts")
                        .where("uid", isEqualTo: userDetails["uid"])
                        .snapshots(),
                    builder: (context, snapshot) {
                      return MasonryGridView.count(
                        crossAxisCount: 3,
                        itemCount: (snapshot.data as dynamic).docs.length,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Image.network(
                            (snapshot.data as dynamic).docs[index]["posturl"],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          );
  }

  //status colum
  Widget statusCol(String statusName, int count) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          statusName,
          style: body,
        ),
        Text(
          count.toString(),
          style: body,
        ),
      ],
    );
  }

  //reusable button
  Widget reusableButton(String text) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: const BoxDecoration(color: ternerycolor),
      child: Center(
        child: Text(
          text,
          style: title,
        ),
      ),
    );
  }
}
