

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_booking/components/Blur_Widget.dart';

import '../constants/constant.dart';

class ProfielTapTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Function()? onTap;

  const ProfielTapTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.icon,
    this.onTap,
  }) : super(key: key);
    @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: BlurWidget(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.05,
              vertical: Get.height * 0.02,
            ),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(
                color: deepPrimaryColor.withOpacity(0.3),
              ),
              color: deepPrimaryColor.withOpacity(0.2),
            ),
            child: Row(
              children: [
                Icon(
                  icon, size: 30,
                  color: Colors.black.withOpacity(0.75),
                  // color: Colors.white,
                ),
                SizedBox(width: Get.width * 0.07),
                Column(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.75),
                        // color: Colors.white,
                      ),
                    ),
                    subtitle != null
                        ? Text(
                      subtitle ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
