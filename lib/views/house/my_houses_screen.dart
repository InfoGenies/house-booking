import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../components/custom_app_bar.dart';
import '../../components/empty_screen.dart';
import '../../components/house_widget.dart';
import '../../constants/constant.dart';

import '../../controllers/house_controller.dart';
import '../../models/house.dart';
import '../../models/user.dart';
import 'create_house_screen.dart';
import 'offers_screen.dart';

class MyHousesScreen extends StatefulWidget {
  final User user;

  const MyHousesScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MyHousesScreen> createState() => _MyHousesScreenState();
}

class _MyHousesScreenState extends State<MyHousesScreen> {
  ScrollController myHousesScrollController = ScrollController();
  HouseController houseController = Get.find<HouseController>() ;
  @override
  void initState() {
     print('the initState is lunched');

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // print('the Callback is lunched');

      await houseController.getHouses(null, widget.user.id);
    });

    myHousesScrollController.addListener(() {
      if ((myHousesScrollController.position.maxScrollExtent * 0.8) <
          myHousesScrollController.position.pixels) {
        // houseController.getNextPage(parameters: parameters);
      }
    });

    super.initState();
  }

  Future deleteHouse(House house) async {
    await houseController.deleteHouse(house.id!);
   // await houseController.getHouses(null, widget.user.id);
    houseController.refreshData(widget.user.id) ;
  }

  @override
  void dispose() {
    houseController.myHouses.clear() ;
    houseController.isHouseLoading = true ;
    super.dispose() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'My Houses',
              backButton: true,
            ),
            SizedBox(height: Get.height * 0.01),
            Expanded(
              child: GetBuilder<HouseController>(
                builder: (context) {
                  return houseController.isEmpty
                      ? houseController.isHouseLoading
                          ? const HouseLoader()
                          : const Center(
                              child: EmptyScreen(
                                title: 'You don\'t create any house yet',
                                icon: FontAwesomeIcons.houseCircleXmark,
                                isExpanded: false,
                              ),
                            )
                      : RefreshIndicator(
                          onRefresh: () async {
                             await houseController.getHouses(null,widget.user.id);
                          },
                          child: SizedBox(
                            height: double.infinity,
                            child: ListView.builder(
                                itemCount: houseController.myHouses.length + 1,
                                shrinkWrap: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                primary: false,
                                controller: myHousesScrollController,
                                itemBuilder: (_, index) => index !=
                                        houseController.myHouses.length
                                    ? Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.02,
                                          vertical: 10,
                                        ),
                                        child: Dismissible(
                                          key: ObjectKey(
                                            houseController.myHouses[index],
                                          ),
                                          background: backgroundSwipping(
                                            Alignment.centerLeft,
                                          ),
                                          secondaryBackground:
                                              backgroundSwipping(
                                            Alignment.centerRight,
                                          ),
                                          onDismissed: (DismissDirection
                                              dismissDirection) async {
                                            if (dismissDirection ==
                                                DismissDirection.startToEnd) {
                                              print('remove====');

                                              // deleteHouse(houseController
                                              //     .myHouses[index]);
                                            }
                                          },
                                          confirmDismiss: (DismissDirection
                                              dismissDirection) async {
                                            if (dismissDirection ==
                                                DismissDirection.startToEnd) {
                                              print('remove');
                                              bool confirmed = false;
                                              await Get.defaultDialog(
                                                title: 'Wait',
                                                content: const Text(
                                                  'Do you want to delete this house ?',
                                                ),
                                                onCancel: () {
                                                  confirmed = false;
                                                  // Get.back();
                                                },
                                                onConfirm: () async {
                                                  confirmed = true;


                                                 await deleteHouse(houseController.myHouses[index]);
                                                  Get.back();
                                                },
                                                confirmTextColor: Colors.white,
                                              );
                                              return confirmed;
                                            } else {
                                              print('edit======');
                                              Get.to(
                                                () => CreateHouseScreen(
                                                  user: widget.user,
                                                  house: houseController
                                                      .myHouses[index],
                                                  isUpdate: true,
                                                ),
                                                transition:
                                                    Transition.rightToLeft,
                                              );
                                              return false;
                                            }
                                          },
                                          child: HouseWidget(
                                            margin: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.03,
                                            ),
                                            house:
                                                houseController.myHouses[index],
                                            onTap: () {
                                              Get.to(
                                                () => OffersScreen(
                                                  house: houseController
                                                      .myHouses[index],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : const SizedBox()),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          FontAwesomeIcons.houseMedical,
          color: Colors.white,
        ),
        onPressed: () => Get.to(() => CreateHouseScreen(user: widget.user,)),
      ),
    );
  }

  Widget backgroundSwipping(AlignmentGeometry alignment) => Container(
        decoration: BoxDecoration(
          color: alignment == Alignment.centerLeft ? Colors.red : primaryColor,
          borderRadius: borderRadius,
        ),
        alignment: alignment,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
        child: Icon(
          alignment == Alignment.centerLeft
              ? FontAwesomeIcons.trashCan
              : FontAwesomeIcons.penToSquare,
          color: Colors.white,
          size: Get.width * 0.08,
        ),
      );
}
