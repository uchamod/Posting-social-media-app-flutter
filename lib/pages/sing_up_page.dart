import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/service/authentication.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';
import 'package:instagram_clone/util/variabals.dart';
import 'package:instagram_clone/widgets/textfiled.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Authentication _authServises = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: screenHorizontalPadding,
              vertical: screenVerticalPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //logo
                Center(
                  child: SvgPicture.asset(
                    "assets/instagram_wordmark_logo_icon_169660.svg",
                    color: primaryColor,
                    height: 80,
                  ),
                ),
                //add profile pic
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(
                          "assets/WhatsApp Image 2024-06-03 at 16.37.25_f9a84384.jpg"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_a_photo,
                          size: 28,
                          color: primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                //log in form
                Column(
                  children: [
                    //add username
                    InputTextFiled(
                      controller: _usernameController,
                      hintText: "Username",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      isHidden: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //add bio
                    InputTextFiled(
                      controller: _bioController,
                      hintText: "Bio",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      isHidden: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //add email
                    InputTextFiled(
                      controller: _emailController,
                      hintText: "Email",
                      inputAction: TextInputAction.next,
                      inputType: TextInputType.emailAddress,
                      isHidden: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //add password
                    InputTextFiled(
                      controller: _passwordController,
                      hintText: "Password",
                      inputAction: TextInputAction.done,
                      inputType: TextInputType.emailAddress,
                      isHidden: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //login button
                    GestureDetector(
                      onTap: () async {
                        _authServises.singUpUser(
                          email: _emailController.text,
                          password: _passwordController.text,
                          username: _usernameController.text,
                          bio: _bioController.text,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.13,
                        decoration: ShapeDecoration(
                          color: ternerycolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Sing Up",
                            style: title.copyWith(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 50,
                ),
                //switch to sing up page

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: label,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sing In",
                        style: label.copyWith(color: ternerycolor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
