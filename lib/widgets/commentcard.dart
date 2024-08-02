import 'package:flutter/material.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';

class Commentcard extends StatelessWidget {
  final snap;
  const Commentcard({super.key, this.snap});

  @override
  Widget build(BuildContext context) {
    //comment card
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5, bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //profile pic
              CircleAvatar(
                backgroundImage: NetworkImage(snap["profUrl"]),
                radius: 20,
              ),
              //coment container
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: textboxfillcolor.withOpacity(0.5),
                ),
                //username and comment
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snap["username"],
                      style: body,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: snap["comment"],
                        hintStyle: hinttext,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        //like to comment
        const Positioned(
            bottom: -4, left: 55, child: Icon(Icons.favorite_border_rounded))
      ],
    );
  }
}
