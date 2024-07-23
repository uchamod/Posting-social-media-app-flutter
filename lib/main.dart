import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobilescreenLayout.dart';
import 'package:instagram_clone/responsive/responsiveLauout.dart';
import 'package:instagram_clone/responsive/webscreenLayout.dart';
import 'package:instagram_clone/util/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Instagram clone",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: const ResponsiveLayout(
        webScreen: Webscreenlayout(),
        mobileScreen: MobileScreenlayout(),
      ),
    );
  }
}
