import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user_model.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:instagram_clone/service/firestore.dart';
import 'package:instagram_clone/service/media.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  //instance
  final MediaAdder _adder = MediaAdder();
  final TextEditingController _controller = TextEditingController();
  final FireStoreMethods _fireStoreMethods = FireStoreMethods();
  Uint8List? _image;
  bool isLoading = false;
  //select image option using dialog box
  _selectImage(BuildContext parentcontext) async {
    //show media selector | dialog box
    return showDialog(
      context: parentcontext,
      builder: (context) {
        return SimpleDialog(
          alignment: Alignment.center,
          backgroundColor: textboxfillcolor,
          title: Text(
            "Create a Post",
            style: title.copyWith(color: primaryColor),
          ),
          children: [
            //take a photo
            SimpleDialogOption(
              child: Text(
                "Take a photo",
                style: hinttext.copyWith(color: ternerycolor),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List image = await _adder.imagePicker(ImageSource.camera);
                setState(() {
                  _image = image;
                });
              },
            ),
            const Divider(),
            //select image from gallery
            SimpleDialogOption(
              child: Text(
                "Take from gallery",
                style: hinttext.copyWith(color: ternerycolor),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List image = await _adder.imagePicker(ImageSource.gallery);
                setState(() {
                  _image = image;
                });
              },
            ),
            const Divider(),
            //cancel selection
            SimpleDialogOption(
              child: Text(
                "Cancel",
                style: hinttext.copyWith(color: errorColor),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //upload new post to firestore
  void uploadNewPost(
      String userid, String username, String email, String profImg) async {
    setState(() {
      isLoading = true;
    });
    try {
      print("waiting...");
      await _fireStoreMethods.uploadPost(
        _controller.text,
        _image!,
        profImg,
        userid,
        username,
        email,
        context,
      );
      setState(() {
        isLoading = false;
      });
      clearPostmood();
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            err.toString(),
            style: body,
          ),
        ),
      );
    }
  }

  //clear posting mood
  void clearPostmood() {
    setState(() {
      _image = null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: textboxfillcolor,
        width: 2,
      ),
    );
    //if img null show iage selector then show the posting option
    return _image == null
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      _selectImage(context);
                    },
                    icon: const Icon(
                      Icons.add_box_sharp,
                      size: 48,
                      color: primaryColor,
                    )),
                Text(
                  "Create New Post",
                  style: title,
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: clearPostmood,
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: primaryColor,
                ),
              ),
              title: Text(
                "Create Post",
                style: title,
              ),
              actions: [
                InkWell(
                  onTap: () {
                    UserModel user = userProvider.getCurrentUser;
                    uploadNewPost(
                        user.user, user.username, user.email, user.proPic);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    margin: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      color: ternerycolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Post",
                      style: title,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isLoading
                      ? const LinearProgressIndicator()
                      : const Padding(
                          padding: EdgeInsets.only(top: 0),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: _image == null
                        ? const AssetImage(
                            "assets/WhatsApp Image 2024-06-03 at 16.37.25_f9a84384.jpg")
                        : MemoryImage(_image!),
                    radius: 65,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    maxLines: 10,
                    style: body,
                    cursorColor: textboxfillcolor,
                    controller: _controller,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: secondaryColor.withOpacity(0.1),
                        contentPadding: EdgeInsets.all(10),
                        border: border,
                        hintText: "Say Something...",
                        hintStyle: hinttext,
                        focusedBorder: border,
                        enabledBorder: border),
                  )
                ],
              ),
            ),
          );
  }
}
