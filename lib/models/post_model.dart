//post model
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String user;
  final String username;
  final String email;
  final String postid;
  final String postUrl;
  final String discription;
  final dynamic likes;

  PostModel(
      {required this.user,
      required this.username,
      required this.email,
      required this.postid,
      required this.postUrl,
      required this.discription,
      required this.likes});

  Map<String, dynamic> toJson() => {
        "uid": user,
        "username": username,
        "email": email,
        "postid": postid,
        "posturl": postUrl,
        "discription": discription,
        "likes": likes
      };
//map user data to user model
  static PostModel mapPostData(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return PostModel(
        user: snapshot["uid"],
        username: snapshot["username"],
        email: snapshot["email"],
        postid: snapshot["postid"],
        postUrl: snapshot["posturl"],
        discription: snapshot["discription"],
        likes: snapshot["likes"]);
  }
}
