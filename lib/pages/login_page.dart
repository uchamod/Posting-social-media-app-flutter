import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';
import 'package:instagram_clone/util/variabals.dart';
import 'package:instagram_clone/widgets/textfiled.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: screenHorizontalPadding,
              vertical: screenVerticalPadding),
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

              //log in form
              Column(
                children: [
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
                    onTap: () {},
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
                          "Log In",
                          style: title.copyWith(color: mobileBackgroundColor),
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
                    "don't you have an account?",
                    style: label,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sing Up",
                      style: label.copyWith(color: ternerycolor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
