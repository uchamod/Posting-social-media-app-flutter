import 'package:cloud_firestore/cloud_firestore.dart';
//comment model
class CommentModel {
  final String commentId;
  final String postId;
  final String userId;
  final String userName;
  final String proPic;
  final String comment;
  final dynamic likes;
  final DateTime publishedData;

  CommentModel(
      {required this.commentId,
      required this.postId,
      required this.userId,
      required this.userName,
      required this.proPic,
      required this.comment,
      required this.likes,
      required this.publishedData});

  Map<String, dynamic> toJson() => {
        "uid": userId,
        "username": userName,
        "commentid": commentId,
        "postid": postId,
        "date": publishedData,
        "comment": comment,
        "likes": likes,
        "profUrl": proPic
      };
//map user data to user model
  static CommentModel mapPostData(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return CommentModel(
      userId: snapshot["uid"],
      userName: snapshot["username"],
      commentId: snapshot["commentid"],
      postId: snapshot["postid"],
      publishedData: snapshot["date"],
      comment: snapshot["comment"],
      likes: snapshot["likes"],
      proPic: snapshot["profUrl"],
    );
  }
}
