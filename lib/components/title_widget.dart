

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TitleWidget extends StatelessWidget {

  final String title;
  final EdgeInsets? margin;
  final TextStyle? textStyle;

  const TitleWidget({
    Key? key,
    required this.title,
    this.margin,
    this.textStyle,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Text(
        title,
        style: textStyle ?? Get.textTheme.titleLarge,
      ),
    );
  }
}
