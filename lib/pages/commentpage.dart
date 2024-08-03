import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/service/firestore.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';
import 'package:instagram_clone/widgets/commentcard.dart';
import 'package:provider/provider.dart';

class Commentpage extends StatefulWidget {
  final postId;
  const Commentpage({super.key, this.postId});

  @override
  State<Commentpage> createState() => _CommentpageState();
}

class _CommentpageState extends State<Commentpage> {
  //comment controller
  final TextEditingController _controller = TextEditingController();

  //commenting
  void commentPost(
      String userId, String userName, String proPic, String comment) async {
    try {
      await FireStoreMethods()
          .commentPost(userId, widget.postId, userName, proPic, comment);
      setState(() {
        _controller.clear();
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel currentUser =
        Provider.of<UserProvider>(context).getCurrentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileSearchColor,
        forceMaterialTransparency: true,
        title: Text(
          "Comments",
          style: title,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .doc(widget.postId)
            .collection("comments")
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //bulid the comment scetion
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Commentcard(
                snap: snapshot.data!.docs[index],
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(currentUser.proPic),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: textFiled(_controller),
                ),
              ),
              InkWell(
                  onTap: () {
                    commentPost(currentUser.user, currentUser.username,
                        currentUser.proPic, _controller.text);
                  },
                  child: const Icon(
                    Icons.send,
                    color: ternerycolor,
                    size: 30,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  //comment text feild
  Widget textFiled(TextEditingController controller) {
    return TextField(
      textInputAction: TextInputAction.done,
      controller: controller,
      maxLines: null,
      minLines: 1,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
          enabled: true,
          filled: true,
          fillColor: textboxfillcolor.withOpacity(0.5),
          hintText: "Comment...",
          hintStyle: hinttext),
    );
  }
}
