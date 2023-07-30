import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:house_booking/components/profile_tap_item.dart';
import 'package:house_booking/data/api/api.dart';
import 'package:house_booking/views/splash_screen.dart';

import '../../components/Blur_Widget.dart';
import '../../components/profiel_tap_tile.dart';
import '../../components/submit_button.dart';
import '../../constants/constant.dart';
import '../../controllers/controller.dart';
import '../house/my_houses_screen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        section(
                          margin: EdgeInsets.only(top: Get.height * 0.01),
                          child: userInfo(),
                          width: Get.width,
                        ),
                        const Spacer(),
                        section(
                          margin: EdgeInsets.only(top: Get.height * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProfileTapItem(
                                icon: FontAwesomeIcons.house,
                                title: 'My houses',
                                onTap: () =>
                                    Get.to(() =>  MyHousesScreen(userId:authController.getId()!)),
                              ),
                              ProfileTapItem(
                                icon: FontAwesomeIcons.clockRotateLeft,
                                title: 'History',
                                onTap: () {},
                              ),
                              ProfileTapItem(
                                icon: FontAwesomeIcons.clipboardList,
                                title: 'Rented',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                        section(
                          margin: EdgeInsets.only(top: Get.height * 0.01),
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.02,
                            vertical: Get.height * 0.02,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfielTapTile(
                                title: 'Settings',
                                icon: FontAwesomeIcons.gears,
                                onTap: () {},
                              ),
                              ProfielTapTile(
                                title: 'Privacy Policy',
                                icon: FontAwesomeIcons.shield,
                                onTap: () {},
                              ),
                              ProfielTapTile(
                                title: 'About Us',
                                icon: FontAwesomeIcons.circleInfo,
                                onTap: () {},
                              ),
                              SubmitButton(
                                text: 'Sign Out',
                                textColor: Colors.black.withOpacity(0.75),
                                fontWeight: FontWeight.bold,
                                color: deepPrimaryColor.withOpacity(0.2),
                                margin: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.02,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.1,
                                  vertical: Get.height * 0.02,
                                ),
                                onTap: () async {
                                  await authController.signOut();
                                  Get.offAll(SplashScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column userInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: authController.user?.picture != null
              ? NetworkImage(
             authController.user?.picture != null ?  '$baseUrl${authController.user?.picture}' : '',
                )
              : null,
          radius: Get.width * 0.1,
          child: authController.user?.picture == null
              ? SvgPicture.asset(
                  'assets/vectors/person.svg',
                )
              : null,
        ),
        SizedBox(height: Get.height * 0.01),
        Text(
          authController.user?.username?.toUpperCase() ?? '',
          style: Get.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black.withOpacity(0.75),
          ),
        ),
        Text(
          authController.user?.userType?.toUpperCase() ?? '',
          style: TextStyle(
            color: Colors.black.withOpacity(0.75),
          ),
        ),
      ],
    );
  }

  Widget section({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? width,
    double? height,
  }) =>
      BlurWidget(
        child: Container(
          width: width,
          height: height,
          margin: margin,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: Get.width * 0.05,
                vertical: Get.height * 0.02,
              ),
          decoration: BoxDecoration(
            color: deepPrimaryColor.withOpacity(0.1),
            borderRadius: borderRadius,
          ),
          child: child,
        ),
      );
}
