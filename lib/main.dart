import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/login_page.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/responsive/mobilescreenLayout.dart';
import 'package:instagram_clone/responsive/responsiveLauout.dart';
import 'package:instagram_clone/responsive/webscreenLayout.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:provider/provider.dart';

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

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: "Instagram clone",
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileSearchColor),
        //check app state and render the relevant state
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              //if user currently singIn
              if (snapshot.hasData) {
                // return const ResponsiveLayout(
                //   webScreen: Webscreenlayout(),
                //   mobileScreen: MobileScreenlayout(),
                // );
                 return const LoginPage();
                //if has some error
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("something went wrong"),
                );
              }
            }
            //if connection not stablish
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            //if user currently sing out
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
