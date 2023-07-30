import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/custom_bttom_navigation_bar.dart';
import '../../controllers/controller.dart';
import '../../controllers/nav_bar_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NavBarController>(
        builder: (_) => navBarController.currentWidget,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
