import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/pages/sing_up_page.dart';
import 'package:instagram_clone/service/authentication.dart';
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
  final Authentication _authentication = Authentication();
  bool isLoadding = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void SingInUserAndToggleHome() async {
    setState(() {
      isLoadding = !isLoadding;
    });
    await _authentication.singInUser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
    setState(() {
      isLoadding = !isLoadding;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  //navigator
  void navigateToSingInPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingUpPage(),
      ),
    );
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
                  "assets/Posting.svg",
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
                  InkWell(
                    onTap: () {
                      SingInUserAndToggleHome();
                      // _emailController.clear();
                      // _passwordController.clear();
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
                      child: isLoadding
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: primaryColor,
                            ))
                          : Center(
                              child: Text(
                                "Log In",
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
                    "don't you have an account?",
                    style: label,
                  ),
                  TextButton(
                    onPressed: navigateToSingInPage,
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
