import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobilescreenLayout.dart';
import 'package:instagram_clone/responsive/responsiveLauout.dart';
import 'package:instagram_clone/responsive/webscreenLayout.dart';
import 'package:instagram_clone/util/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //check if app run on mobile or web
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDJllauOFYERnL7Yf4SVyuOtAueB7hjgJg",
          appId: "1:1069404306101:web:03f568e7f4e555f5011cfc",
          messagingSenderId: "1069404306101",
          projectId: "instagram-clone-5457e",
          storageBucket: "instagram-clone-5457e.appspot.com"),
    );
  } else {
    await Firebase.initializeApp();
  }

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
