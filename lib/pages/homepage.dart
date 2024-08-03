import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/widgets/postcard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileSearchColor,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: SvgPicture.asset(
          "assets/Posting.svg",
          height: 50,
          color: primaryColor,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.messenger_outline_outlined,
                size: 24,
                color: primaryColor,
              ))
        ],
      ),
      //get the post data
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ignore: prefer_const_constructors
            return Center(
              child: const CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Postcard(snap: snapshot.data!.docs[index].data());
            },
          );
        },
      ),
    );
  }
}
