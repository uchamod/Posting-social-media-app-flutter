import 'package:flutter/material.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';

class Postcard extends StatefulWidget {
  const Postcard({super.key});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(padding: EdgeInsets.only(left: 13)),
              const CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/WhatsApp Image 2024-06-03 at 16.37.25_f9a84384.jpg"),
                radius: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Taylor Swift",
                  style: body,
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    size: 24,
                    color: primaryColor,
                  ))
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          TextField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 13),
              border: InputBorder.none,
              hintText: "Love it",
              hintStyle: body.copyWith(fontWeight: FontWeight.w200),
              enabled: false,
            ),
          ),
          //post image
          Image.asset(
            "assets/WhatsApp Image 2024-06-03 at 16.37.24_9574b07c.jpg",
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
          //fottor
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.comment_outlined,
                    size: 30,
                    color: primaryColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_rounded,
                    size: 30,
                    color: primaryColor,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share_outlined,
                    size: 30,
                    color: primaryColor,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
