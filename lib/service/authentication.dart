import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobilescreenLayout.dart';
import 'package:instagram_clone/responsive/responsiveLauout.dart';
import 'package:instagram_clone/responsive/webscreenLayout.dart';
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

  Future<void> singUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      String proPic = "",
      required BuildContext context}) async {
    try {
      //create a new user
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        //get created user id
        final user = userCredential.user!.uid;

        //  String url = await _storageServices.uploadImagesToStorage(
        //       "profile pics", imgfile, false);
        //store user data
        await _firestorege.collection("users").doc(user).set({
          "uid": user,
          "username": username,
          "email": email,
          "password": password,
          "bio": bio,
          "avatar": proPic,
          "followers": [],
          "following": [],
        });
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
}
