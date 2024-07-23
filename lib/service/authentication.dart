

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//add firebase auth methods to sing up and sing in users
class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestorege = FirebaseFirestore.instance;
  Future<String> singUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
    //  required Uint8List imgfile
      }) async {
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
        //store user data
        await _firestorege.collection("users").doc(user).set({
          "uid": user,
          "username": username,
          "email": email,
          "password": password,
          "bio": bio,
          "followers": [],
          "following": [],
        });
        print("succuss");
      }
      print("details missing");
    } catch (err) {
      print(err.toString());
    }
    return "";
  }
}
