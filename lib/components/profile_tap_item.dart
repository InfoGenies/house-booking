

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';

class ProfileTapItem extends StatelessWidget {

  final IconData icon;
  final String title;
  final Function()? onTap;

  const ProfileTapItem({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: Get.width * 0.25,
        padding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: deepPrimaryColor.withOpacity(0.3),
          ),
          color: deepPrimaryColor.withOpacity(0.2),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.black.withOpacity(0.75),
              // color: Colors.white,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.75),
                // color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
