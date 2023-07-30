import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final EdgeInsetsGeometry? margin;
  final TextInputType? keyboardType;
  Function(String)? onChange;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  Widget? prefixIcon;
  final Color borderColor;

  CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
    this.obscureText = false,
    this.keyboardType,
    this.onChange,
    this.prefixIcon,
    this.borderColor = primaryColor,
    this.readOnly = false,
    this.onTap,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        onChanged: onChange,
        obscureText: obscureText,
        keyboardType: keyboardType,
        onTap: onTap,
        onSubmitted: onSubmitted,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: borderColor,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(
              color: borderColor,
            ),
          ),
        ),
      ),
    );
  }
}
