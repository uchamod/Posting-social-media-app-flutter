import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/service/authentication.dart';
import 'package:instagram_clone/service/media.dart';
import 'package:instagram_clone/service/storage.dart';
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
  final Authentication _authServises = Authentication();
  final MediaAdder _adder = MediaAdder();
  Uint8List? _image;
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void imageSelector() async {
    Uint8List img = await _adder.imagePicker(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  //sing up user:store pro pic and other data
  singUpUser() async {
    setState(() {
      isLoading = !isLoading;
    });
    String url = await StorageServices()
        .uploadImagesToStorage("profile pics", _image!, false);
    await _authServises.singUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        proPic: url,
        context: context);
    setState(() {
      isLoading = !isLoading;
    });
  }

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
                    _image != null
                        ? CircleAvatar(
                            radius: 65,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 65,
                            backgroundColor: textboxfillcolor,
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: imageSelector,
                        icon: const Icon(
                          Icons.add_a_photo,
                          size: 28,
                          color: primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
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
                    InkWell(
                      onTap: singUpUser,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.13,
                        decoration: ShapeDecoration(
                          color: ternerycolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: !isLoading
                            ? Center(
                                child: Text(
                                  "Sing Up",
                                  style: title.copyWith(color: primaryColor),
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                color: primaryColor,
                              )),
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
