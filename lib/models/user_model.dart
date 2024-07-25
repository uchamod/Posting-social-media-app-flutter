//user model
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String user;
  final String username;
  final String email;
  final String password;
  final String bio;
  final String proPic;
  final List followres;
  final List following;

  UserModel(
      {required this.user,
      required this.username,
      required this.email,
      required this.password,
      required this.bio,
      required this.proPic,
      required this.followres,
      required this.following});
  Map<String, dynamic> toJson() => {
        "uid": user,
        "username": username,
        "email": email,
        "password": password,
        "bio": bio,
        "avatar": proPic,
        "followers": followres,
        "following": following,
      };
//map user data to user model
  static UserModel mapUserData(DocumentSnapshot snap) {
    var snapshot = (snap.data() as Map<String, dynamic>);
    return UserModel(
      user: snapshot["uid"],
      username: snapshot["username"],
      email: snapshot["email"],
      password: snapshot["password"],
      bio: snapshot["bio"],
      proPic: snapshot["avatar"],
      followres: snapshot["followers"],
      following: snapshot["following"],
    );
  }
}
