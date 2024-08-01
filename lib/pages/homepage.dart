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
      body: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Postcard(),
            ],
          ),
        ),
      ),
    );
  }
}
