import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/pages/commentpage.dart';
import 'package:instagram_clone/pages/profilepage.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/service/firestore.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';
import 'package:instagram_clone/widgets/likeanimation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Postcard extends StatefulWidget {
  final snap;
  const Postcard({super.key, this.snap});

  @override
  State<Postcard> createState() => _PostcardState();
}

class _PostcardState extends State<Postcard> {
  int comment = 0;
  //varibles
  bool isAnimate = false;
  @override
  void initState() {
    super.initState();
    fetchCommentLenth();
  }

  //fethch comment lenth
  void fetchCommentLenth() async {
    try {
      //fetch the documents
      QuerySnapshot docSnap = await FirebaseFirestore.instance
          .collection("posts")
          .doc(widget.snap["postid"])
          .collection("comments")
          .get();

      comment = docSnap.docs.length;
    } catch (err) {
      print(err.toString() + "some thing happend");
    }
    setState(() {});
  }

  ///deletepost
  void deletePost(String postid) async {
    await FireStoreMethods().deletePost(postid);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    ///get current user
    final UserModel currentUser =
        Provider.of<UserProvider>(context).getCurrentUser;
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(userId: widget.snap["uid"]),
                      ));
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.snap["profUrl"].toString(),
                  ),
                  radius: 20,
                ),
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
              //menu icon
              IconButton(
                  onPressed: () {
                    //show menu
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: textboxfillcolor,
                          elevation: 1,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.center,
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            shrinkWrap: true,
                            children: ["Remove Post", "Save Post"]
                                .map((ele) => InkWell(
                                      onTap: () {
                                        ele == "Remove Post"
                                            ? Navigator.of(context).pop()
                                            : Navigator.of(context).pop();
                                      },
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
          //discription
          //ToDo place
          Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 13, right: 8),
            child: Text(
              widget.snap["discription"].toString(),
              style: body.copyWith(fontWeight: FontWeight.w200),
            ),
          ),
          //post image
          GestureDetector(
            onDoubleTap: () async {
              await FireStoreMethods().likePost(widget.snap['postid'],
                  currentUser.user, widget.snap['likes']);

              setState(() {
                isAnimate = true;
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                //post
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.42,
                  width: double.infinity,
                  child: Image.network(
                    widget.snap["posturl"].toString(),
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
                //like animation
                Center(
                  child: AnimatedOpacity(
                    opacity: isAnimate ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Likeanimation(
                      isAnimating: isAnimate,
                      duration: const Duration(milliseconds: 300),
                      onEnd: () {
                        setState(() {
                          isAnimate = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite_rounded,
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //likes and comments section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  widget.snap['likes'].length.toString() + " likes",
                  style: label.copyWith(fontSize: 14, color: secondaryColor),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "$comment comments",
                  style: label.copyWith(fontSize: 14, color: secondaryColor),
                ),
              ),
            ],
          ),
          //fottor
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //comment
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Commentpage(
                            postId: widget.snap["postid"],
                          ),
                        ));
                  },
                  icon: const Icon(
                    Icons.comment_outlined,
                    size: 30,
                    color: primaryColor,
                  )),
              //like
              IconButton(
                icon: Icon(
                  widget.snap["likes"].contains(currentUser.user)
                      ? Icons.favorite
                      : Icons.favorite_border_rounded,
                  size: 30,
                  color: primaryColor,
                ),
                onPressed: () {
                  FireStoreMethods().likePost(widget.snap['postid'].toString(),
                      currentUser.user, widget.snap['likes']);
                },
              ),
              //share
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
