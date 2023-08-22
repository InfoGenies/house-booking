import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final String title;
  final bool backButton;
  final double padding;
  final double? width;
  final double? height;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.padding = 15.0,
    this.title = '',
    this.trailing,
    this.backButton = false,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // when the width and height is null the container will take the minimum required width and height based on its child content
    // so here the container is based on here child
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Positioned(
            left: padding,
            child: leading ??
                (backButton
                    ? InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black54,
                        ),
                        onTap: () => Get.back(),
                      )
                    : const SizedBox()),
          ),
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: padding,
            child: trailing ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
