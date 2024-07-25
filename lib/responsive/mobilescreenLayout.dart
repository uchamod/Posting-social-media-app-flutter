import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';

class MobileScreenlayout extends StatefulWidget {
  const MobileScreenlayout({super.key});

  @override
  State<MobileScreenlayout> createState() => _MobileScreenlayoutState();
}

class _MobileScreenlayoutState extends State<MobileScreenlayout> {
  @override
 

  @override
  Widget build(BuildContext context) {
    //   UserProvider userProvider = UserProvider();
    UserModel user = Provider.of<UserProvider>(context).getCurrentUser;

    return Scaffold(
      body: Center(
        child: Text(
          user.username,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
 // String username = "";

  // //get current user data as snapshot
  // Future<void> getUserName() async {
  //   DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();

  //   setState(() {
  //     username = (snapshot.data() as Map<String, dynamic>)["username"];
  //   });
  // }

     // addData() async {
    //   UserProvider userProvider =
    //       Provider.of<UserProvider>(context, listen: true);
    //   await userProvider.refreshUser();
    // }