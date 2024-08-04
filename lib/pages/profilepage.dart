import 'package:flutter/material.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  final String bio;
  final String profilePic;
  final String userId;
  final posts;
  final int follow;
  final int following;
  final bool isUser;
  const ProfilePage(
      {super.key,
      required this.username,
      required this.bio,
      required this.profilePic,
      this.posts,
      required this.follow,
      required this.following,
      required this.isUser,
      required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileSearchColor,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        actions: [
          //log out action
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Sing Out",
                style: body.copyWith(fontSize: 14),
              ),
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.logout,
                size: 24,
                color: primaryColor,
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          //user details section
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.only(left: 10)),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.profilePic),
                radius: 70,
              ),
              const Padding(padding: EdgeInsets.only(left: 15)),
              //username | bio | edit/follow
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.username,
                    style: title,
                  ),
                  Text(
                    widget.bio,
                    style: hinttext,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 6)),
                  //edit/follow button
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 7),
                      decoration: const BoxDecoration(color: ternerycolor),
                      child: Center(
                        child: Text(
                          widget.isUser ? "Edit Profile" : "Follow",
                          style: title,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 15),
          ),
          //status section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              statusCol("posts", 10),
              statusCol("following", widget.following),
              statusCol("followers", widget.follow),
            ],
          )
        ],
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
}
