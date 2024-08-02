import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/comment_model.dart';
import 'package:instagram_clone/models/post_model.dart';
import 'package:instagram_clone/service/storage.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void massage(String res, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: textboxfillcolor,
        content: Text(
          res,
          style: body,
        ),
      ),
    );
  }

  //upload a new post
  Future<void> uploadPost(
    String discription,
    Uint8List postimg,
    String profimg,
    String userid,
    String username,
    String email,
    BuildContext context,
  ) async {
    try {
      //get post url
      String url =
          await StorageServices().uploadImagesToStorage("posts", postimg, true);
      String postid = Uuid().v1();
      PostModel newPost = PostModel(
          user: userid,
          publishedDate: DateTime.now(),
          username: username,
          email: email,
          postid: postid,
          postUrl: url,
          profUrl: profimg,
          discription: discription,
          likes: []);
      //upload to post collection
      await _firestore.collection("posts").doc(postid).set(newPost.toJson());
      massage("Posting Succsussfuly", context);
    } catch (err) {
      massage(err.toString(), context);
    }
  }

  //like a post
  Future<void> likePost(String postid, String userId, List likes) async {
    try {
      //if the userid already exist in list remove the userid(dislike the post)
      if (likes.contains(userId)) {
        await _firestore.collection("posts").doc(postid).update({
          "likes": FieldValue.arrayRemove([userId])
        });
      } else {
        //if the userid not exist in list add the userid(like the post)
        await _firestore.collection("posts").doc(postid).update({
          "likes": FieldValue.arrayUnion([userId])
        });
      }
    } catch (err) {
      print(err.toString() + "something happend");
    }
  }

  //comment a post
  Future<void> commentPost(String userId, String postId, String userName,
      String proPic, String comment) async {
    try {
      //comment id
      String commentId = Uuid().v4();
      CommentModel commentModel = CommentModel(
          commentId: commentId,
          postId: postId,
          userId: userId,
          userName: userName,
          proPic: proPic,
          comment: comment,
          likes: [],
          publishedData: DateTime.now());
      //set new comment
      await _firestore
          .collection("posts")
          .doc(postId)
          .collection("comments")
          .doc(commentId)
          .set(commentModel.toJson());
      print("commented");
    } catch (err) {
      print(err.toString() + "not commented");
    }
  }
}
