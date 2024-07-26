import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          username: username,
          email: email,
          postid: postid,
          postUrl: url,
          discription: discription,
          likes: []);
      //upload to post collection    
    await  _firestore.collection("posts").doc(postid).set(newPost.toJson());
      massage("Posting Succsussfuly", context);
    } catch (err) {
      massage(err.toString(), context);
    }
  }
}
