import 'package:flutter/material.dart';
import 'package:instagram_clone/util/colors.dart';
import 'package:instagram_clone/util/text_styles.dart';

class InputTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final String hintText;
  final bool isHidden;
  dynamic sufficxWidget;
//  final String? Function(String?) isValid;
  InputTextFiled(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.inputAction,
      required this.inputType,
      required this.isHidden,
      this.sufficxWidget});

  @override
  Widget build(BuildContext context) {
    final inputfieldborder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5), borderSide: BorderSide.none
        //  borderSide: const BorderSide(color: secondaryColor, width: 2),
        );
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.none,
      cursorColor: primaryColor,
      cursorErrorColor: errorColor,
      enableSuggestions: true,
      textInputAction: inputAction,
      keyboardType: inputType,
      style: body,
      cursorHeight: 20,
      obscureText: isHidden,
      decoration: InputDecoration(
        filled: true,
        fillColor: textboxfillcolor.withOpacity(0.5),
        suffixIcon: sufficxWidget,
        contentPadding: const EdgeInsets.all(18),
        hintText: hintText,
        hintStyle: hinttext,
        enabledBorder: inputfieldborder,
        focusedBorder: inputfieldborder,
        border: InputBorder.none,
        errorBorder: inputfieldborder,
      ),
    );
  }
}
