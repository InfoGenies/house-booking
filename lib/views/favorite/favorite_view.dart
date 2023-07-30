import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../components/custom_app_bar.dart';
import '../../components/empty_screen.dart';
import '../../components/house_widget.dart';
import '../../components/swipe_help.dart';
import '../../constants/constant.dart';
import '../../controllers/controller.dart';
import '../../controllers/favorite_controller.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      if (favoriteController.isEmpty) {
        favoriteController.changeLoadingState(true);
        await Future.delayed(const Duration(milliseconds: 300));
        favoriteController.getFavorites(authController.getId()!);
      } else {
        favoriteController.changeLoadingState(false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(title: 'Favorite'),
            SizedBox(height: Get.height * 0.01),
            Expanded(
              child: GetBuilder<FavoriteController>(
                builder: (context) {
                  return favoriteController.isLoading
                      ? const HouseLoader()
                      : Column(
                          children: [
                            favoriteController.isEmpty
                                ? const EmptyScreen(
                                    title: 'No favorite yet',
                                    icon: FontAwesomeIcons.heart,
                                  )
                                : Expanded(
                                    child: Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        RefreshIndicator(
                                          onRefresh: () async {
                                            await favoriteController
                                                .getFavorites(
                                                    authController.getId()!);
                                          },
                                          child: SizedBox(
                                            height: double.infinity,
                                            child: ListView.builder(
                                              itemCount: favoriteController
                                                  .favorites.length,
                                              shrinkWrap: true,
                                              itemBuilder: (_, index) =>
                                                  Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.02,
                                                  vertical: 10,
                                                ),
                                                child: Dismissible(
                                                  key: ObjectKey(
                                                    favoriteController
                                                        .favorites[index],
                                                  ),
                                                  background:
                                                      backgroundSwipping(
                                                          Alignment.centerLeft),
                                                  secondaryBackground:
                                                      backgroundSwipping(
                                                          Alignment
                                                              .centerRight),
                                                  onDismissed: (DismissDirection
                                                      dismissDirection) {},
                                                  confirmDismiss: (DismissDirection
                                                      dismissDirection) async {
                                                    return await favoriteController
                                                        .deleteFavoriteItems(
                                                            favoriteController
                                                                .favorites[
                                                                    index]
                                                                .id!,authController.getId()! );
                                                  },
                                                  child: HouseWidget(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          Get.width * 0.03,
                                                    ),
                                                    offer: favoriteController
                                                        .favorites[index]
                                                        .offer!,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                          top: 5,
                                          child: SwipeHelp(
                                            text:
                                                'swipe on an item to delete or edit',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget backgroundSwipping(AlignmentGeometry alignment) => Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: borderRadius,
        ),
        alignment: alignment,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: Icon(
          FontAwesomeIcons.trashCan,
          color: Colors.white,
          size: Get.width * 0.08,
        ),
      );
}
