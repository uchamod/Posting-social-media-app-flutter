import 'package:flutter/material.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';

class Commentcard extends StatelessWidget {
  final snap;
  const Commentcard({super.key, this.snap});

  @override
  Widget build(BuildContext context) {
    //comment card
    return Column(
      children: [
        Stack(
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
                        Text(
                          snap["comment"],
                          style: hinttext,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //like to comment
            const Positioned(
                bottom: -3,
                left: 55,
                child: Icon(
                  Icons.favorite_border_rounded,
                  size: 20,
                )),
          ],
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}

    // ListTile(
    //                     minLeadingWidth: double.infinity,
    //                     visualDensity: VisualDensity.adaptivePlatformDensity,
    //                     title: Text(
    //                       snap["username"],
    //                       style: body,
    //                     ),
    //                     subtitle: Text(
    //                       snap["comment"],
    //                       style: hinttext,
    //                     ),
    //                   ),