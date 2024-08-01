import 'package:flutter/material.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';
import 'package:intl/intl.dart';

class Postcard extends StatefulWidget {
  final snap;
  const Postcard({super.key, this.snap});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(padding: EdgeInsets.only(left: 13)),
              //profile image
              CircleAvatar(
                backgroundImage: NetworkImage(
                  widget.snap["profUrl"].toString(),
                ),
                radius: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.snap["username"],
                      style: body,
                    ),
                    Text(
                      DateFormat.yMMMd().format(widget.snap['date'].toDate()),
                      style: label.copyWith(color: secondaryColor),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: textboxfillcolor,
                          elevation: 1,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.topRight,
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            shrinkWrap: true,
                            children: ["Remove Post", "Save Post"]
                                .map((ele) => InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          ele,
                                          style: hinttext.copyWith(
                                              color: primaryColor),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.more_vert_rounded,
                    size: 24,
                    color: primaryColor,
                  ))
            ],
          ),
          //ToDo place
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
            child: Text(
              widget.snap["discription"].toString(),
              style: body.copyWith(fontWeight: FontWeight.w200),
            ),
          ),
          //post image
          Image.network(
            widget.snap["posturl"].toString(),
            alignment: Alignment.center,
            fit: BoxFit.contain,
          ),
          //likes and comments section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  "likes " + widget.snap["likes"].length.toString(),
                  style: label.copyWith(fontSize: 14, color: secondaryColor),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "1.1k comments",
                  style: label.copyWith(fontSize: 14, color: secondaryColor),
                ),
              ),
            ],
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
