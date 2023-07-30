import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';
import '../controllers/controller.dart';
import 'authentification/authentification_view.dart';
import 'home/home_view.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  bool isFirstTime = true;

  final String introText = 'Booking House app\nRent a house now';

  Future<void> goToNextScreen() async {
    try {
      await authController.initData();
      if (authController.isLogin) {
        await authController.getInfoUser(userId:authController.getId());
 //       await houseController.getHouses(null,authController.getId());

        await Get.offAll(
          () => const HomeView(),
        );
      } else {
        Get.offAll(
          () => AuthenticationView(),
        );
      }
    } on DioError catch (e) {
      String message = e.message.toString();
      if (e.message == 'Http status error [401]') {
        message = e.message;
        authController.signOut();
      } else if (e.error.runtimeType == SocketException) {
        message = (e.error as SocketException).message;
      }

      Get.defaultDialog(
          title: 'Error',
          content: Text(
            'Error type: $message',
          ),
          confirm: TextButton(
            onPressed: () async {
              Get.back();
              await Future.delayed(const Duration(seconds: 1));
              goToNextScreen();
            },
            child: const Text('Retry'),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.08,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: Get.height * 0.5,
              child: SvgPicture.asset(
                'assets/vectors/splash.svg',
              ),
            ),
            SizedBox(
              height: 80,
              width: Get.width,
              child: DefaultTextStyle(
                style: Get.theme.textTheme.headlineMedium?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ) ??
                    const TextStyle(),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      introText,
                      speed: Duration(
                        milliseconds: 2000 ~/ introText.length,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  pause: const Duration(seconds: 2),
                  onNextBeforePause: (i, b) {
                    if (isFirstTime) {
                      goToNextScreen();
                      isFirstTime = false;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
