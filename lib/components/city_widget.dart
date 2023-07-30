import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';
import '../models/City.dart';
import '../views/city/city_view.dart';

class CityWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final City city;

  const CityWidget(
      {Key? key, required this.city, this.height, this.width, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        () => CityView(city: city),
        transition: Transition.upToDown,
      ),
      child: Hero(
        tag: city.id!,
        child: Container(
          height: height,
          width: width,
          margin: margin ?? const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Colors.black,
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.7,
              image: NetworkImage(
                city.picture!,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            city.name!,
            style: Get.theme.textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
