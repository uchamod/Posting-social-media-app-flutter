import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/responsive/mobilescreenLayout.dart';
import 'package:instagram_clone/responsive/responsiveLauout.dart';
import 'package:instagram_clone/responsive/webscreenLayout.dart';
import 'package:instagram_clone/service/storage.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';

//add firebase auth methods to sing up and sing in users
class Authentication {
  //instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestorege = FirebaseFirestore.instance;

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

  //get current user detils
  Future<UserModel> getUserDetails() async {
    User? user = _auth.currentUser;
    DocumentSnapshot snapshot =
        await _firestorege.collection("users").doc(user!.uid).get();

    return UserModel.mapUserData(snapshot);
  }

  Future<void> singUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      required Uint8List? proPic,
      required BuildContext context}) async {
    try {
      //create a new user
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          proPic != null) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        String url = await StorageServices()
            .uploadImagesToStorage("profile pics", proPic, false);
        //get created user id
        final user = userCredential.user!.uid;
        UserModel newUser = UserModel(
            user: user,
            username: username,
            email: email,
            password: password,
            bio: bio,
            proPic: url,
            followres: [],
            following: []);
        //store user data
        await _firestorege.collection("users").doc(user).set(newUser.toJson());
        massage("Succsussful Registation", context);
        //navigate to homepage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              webScreen: Webscreenlayout(),
              mobileScreen: MobileScreenlayout(),
            ),
          ),
        );
      } else {
        massage("You have missing data", context);
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        massage("Invalid email format", context);
      } else {
        massage("Invalid password format", context);
      }
    } catch (err) {
      massage("something went wrong", context);
    }
  }

  //login user
  Future<void> singInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    // String response = "Invalid username or password";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              webScreen: Webscreenlayout(),
              mobileScreen: MobileScreenlayout(),
            ),
          ),
        );
        // massage("Succsussfuly Log In", context);
      } else {
        massage("Missing credientials", context);
      }
    } catch (err) {
      massage(err.toString(), context);
    }
  }
 //SING OUT USER
  Future<void> singOut() async {
    await _auth.signOut();
  }
}

       