
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';

class CustomDropDown<T> extends StatelessWidget {

  T? value;
  List<T> items;
  final Function(T?)? onChange;
  final EdgeInsetsGeometry? margin;

  CustomDropDown({
    Key? key,
    this.value,
    required this.items,
    this.onChange,
    this.margin,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: margin ?? EdgeInsets.symmetric(vertical: Get.height * 0.01),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: borderRadius,
        border: Border.all(color: primaryColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        alignment: Alignment.center,
        children: [
          DropdownButton<T>(
            onChanged: onChange,
            value: value,
            hint: Container(
              width: Get.width,
              alignment: Alignment.center,
              child: const Text(
                'Account Type',
                textAlign: TextAlign.center,
              ),
            ),
            items: items
                .map(
                  (e) => DropdownMenuItem<T>(
                value: e,
                child: Container(
                  width: Get.width,
                  alignment: Alignment.center,
                  child: Text(
                    e.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
                .toList(),
            alignment: Alignment.center,
            borderRadius: borderRadius,
            underline: const SizedBox(),
            dropdownColor: backgroundColor,
            isExpanded: true,
            icon: const SizedBox(),
          ),
          const Positioned(
            right: 0,
            child: Icon(
              FontAwesomeIcons.caretDown,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
