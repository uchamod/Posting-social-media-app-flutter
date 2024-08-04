import 'package:flutter/material.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';

class ReusableTextfiled extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  Function()? onSubmit;
  ReusableTextfiled(
      {super.key, required this.controller, required this.hint, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (String _) {
        onSubmit;
      },
      textInputAction: TextInputAction.done,
      controller: controller,
      maxLines: null,
      minLines: 1,
      cursorColor: primaryColor,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              width: 0,
            ),
          ),
          enabled: true,
          filled: true,
          fillColor: textboxfillcolor.withOpacity(0.5),
          hintText: hint,
          hintStyle: hinttext),
    );
  }
}
