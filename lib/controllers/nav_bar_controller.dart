import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/chat/chat_tap.dart';
import '../views/favorite/favorite_view.dart';
import '../views/home/home_tap.dart';
import '../views/profile/profile_view.dart';

class NavBarController extends GetxController {
  static NavBarController instance = Get.find();

  int currentPage = 0;

  Widget get currentWidget => pages[currentPage];


  List<Widget> pages = [
    const HomeTap(),
    const ChatTap(),
    const FavoriteView(),
    const ProfileView(),
  ];


  void onChange(int index) {
    currentPage = index;
    update();
  }
}
