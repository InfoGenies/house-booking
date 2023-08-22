

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../constants/constant.dart';

class OfferItemLoader extends StatelessWidget {
  const OfferItemLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SkeletonLoader(
        baseColor: deepPrimaryColor.withOpacity(0.1),
        builder: Container(
          margin: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: Get.width * 0.05,
          ),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.white,
          ),
          child: const ListTile(
            title: Text(''),
            subtitle: Text(''),
          ),
        ),
        items: 10,
        period: const Duration(seconds: 2),
        highlightColor: primaryColor.withOpacity(0.6),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
