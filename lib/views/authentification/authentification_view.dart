import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:house_booking/views/home/home_view.dart';

import '../../components/custom_drop_down.dart';
import '../../components/custom_text_field.dart';
import '../../components/submit_button.dart';
import '../../constants/constant.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/controller.dart';

class AuthenticationView extends StatelessWidget {
  AuthenticationView({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();
  String? accountType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Obx(
                  () => Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.4,
                        child: authController.authenticationMode.value ==
                                AuthenticationMode.signIn
                            ? SvgPicture.asset('assets/vectors/sign_in.svg')
                            : SvgPicture.asset('assets/vectors/sign_up.svg'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          authModeButton(AuthenticationMode.signIn),
                          authModeButton(AuthenticationMode.signUp),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.03),
                      CustomTextField(
                        hintText: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      authController.authenticationMode.value ==
                              AuthenticationMode.signUp
                          ? CustomTextField(
                              hintText: 'Username',
                              controller: usernameController,
                            )
                          : const SizedBox(),
                      CustomTextField(
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                      authController.authenticationMode.value ==
                              AuthenticationMode.signUp
                          ? CustomTextField(
                              hintText: 'Confirm Password',
                              controller: confirmPasswordController,
                              obscureText: true,
                            )
                          : const SizedBox(),
                      authController.authenticationMode.value ==
                              AuthenticationMode.signUp
                          ? CustomDropDown<String>(
                              items: const ['Owner', 'Tenant'],
                              value: accountType,
                              onChange: (val) {
                                accountType = val;
                                authController.authenticationMode.refresh();
                              },
                            )
                          : const SizedBox(),
                      SubmitButton(
                        text: authController.authenticationMode.value ==
                                AuthenticationMode.signIn
                            ? 'Sign In'
                            : 'Sign Up',
                        onTap: () async {
                          // print(accountType);
                          try {
                            authController.isLoading.value = true;
                            if (authController.authenticationMode.value ==
                                AuthenticationMode.signIn) {
                              await authController.signIn(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            } else {
                              await authController.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                username: usernameController.text,
                                userType: accountType ?? 'Tenant',
                              );
                            }
                            if (authController.isLogin) {
                              await authController.getInfoUser(
                                  userId: authController.getId());
                              await houseController.getHouses(
                                  null, authController.getId());

                              Get.offAll(() => const HomeView());
                            }
                          } on DioError catch (e) {
                            Get.defaultDialog(
                              title: 'Error',
                              content: Text(
                                (e.response ?? 'Check your internet connection')
                                    .toString(),
                              ),
                              confirm: TextButton(
                                onPressed: () => Get.back(),
                                child: const Text('Ok'),
                              ),
                            );
                            print('===========');
                            print(e.response);
                          }
                          authController.isLoading.value = false;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => authController.isLoading.value
                ? Container(
                    width: Get.width,
                    height: Get.height,
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget authModeButton(AuthenticationMode authMode) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          authController.authenticationMode.value = authMode;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: Text(
            authMode == AuthenticationMode.signIn ? 'Sign In' : 'Sign Up',
            style: TextStyle(
              color: authController.authenticationMode.value == authMode
                  ? primaryColor
                  : null,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
}
