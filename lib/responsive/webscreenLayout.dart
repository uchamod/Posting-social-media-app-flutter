import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';

class Webscreenlayout extends StatelessWidget {
  const Webscreenlayout({super.key});

  @override
  Widget build(BuildContext context) {
     UserModel user = Provider.of<UserProvider>(context).getCurrentUser;
    return  Scaffold(
      body: Center(
        child: Text(user.proPic),
      ),
    );
  }
}
