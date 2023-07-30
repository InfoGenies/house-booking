import 'dart:ui';

import 'package:flutter/material.dart';

import '../constants/constant.dart';

class BlurWidget extends StatelessWidget {
  final Widget child;
  final bool isBlur;
  final BorderRadius borderRadius;

  const BlurWidget({
    Key? key,
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.isBlur = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: isBlur ? blurEffect : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: child,
      ),
    );
  }
}
