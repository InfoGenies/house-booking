import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../components/city_widget.dart';
import '../../components/custom_text_field.dart';
import '../../components/empty_screen.dart';
import '../../components/house_widget.dart';
import '../../components/title_widget.dart';
import '../../constants/constant.dart';
import '../../controllers/controller.dart';
import '../../controllers/house_controller.dart';
import '../../controllers/offer_controller.dart';
import '../search/search_view.dart';

class HomeTap extends StatefulWidget {
  const HomeTap({Key? key}) : super(key: key);

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  ScrollController offersScrollController = ScrollController();
  OfferController offerController = Get.put(OfferController());
  HouseController houseController = Get.find<HouseController>();


  @override
  void initState() {
    if(offerController.offers.isEmpty){
      offerController.getOffers();
    }
    super.initState();
  }

  @override
  void dispose() {
    offerController.offers.clear();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
           // await offerController.onInit();
            await houseController.getCities();
          },
          child: SingleChildScrollView(
            controller: offersScrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.03),
                CustomTextField(
                  hintText: 'Search',
                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  borderColor: deepPrimaryColor,
                  onTap: () => Get.to(
                    () => const SearchView(),
                    transition: Transition.downToUp,
                  ),
                  readOnly: true,
                  prefixIcon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: deepPrimaryColor,
                  ),
                ),
                TitleWidget(
                  title: 'Cities',
                  margin: EdgeInsets.symmetric(
                    vertical: Get.height * 0.03,
                    horizontal: Get.width * 0.05,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.14,
                  child: GetBuilder<HouseController>(builder: (context) {
                    return ListView.builder(
                      itemCount: houseController.cities.length,
                      itemBuilder: (_, index) => CityWidget(
                        city: houseController.cities[index],
                        margin:
                            const EdgeInsets.symmetric(horizontal: 10).copyWith(
                          left: index == 0 ? Get.width * 0.05 : null,
                        ),
                        height: Get.height * 0.14,
                        width: Get.height * 0.15,
                      ),
                      shrinkWrap: false,
                      scrollDirection: Axis.horizontal,
                    );
                  }),
                ),
                TitleWidget(
                  title: 'Houses',
                  margin: EdgeInsets.symmetric(
                    vertical: Get.height * 0.03,
                    horizontal: Get.width * 0.05,
                  ),
                ),
                GetBuilder<OfferController>(
                  builder: (_) => offerController.isEmpty
                      ? offerController.isLoading
                          ? const HouseLoader()
                          : const Center(
                              child: EmptyScreen(
                                title: 'No Houses yet',
                                icon: FontAwesomeIcons.houseCircleExclamation,
                                isExpanded: false,
                              ),
                            )
                      : ListView.builder(
                          itemCount: offerController.offers.length + 1,
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (_, index) => index !=
                                  offerController.offers.length
                              ? HouseWidget(
                                  offer: offerController.offers[index],
                                )
                              : offerController.isGetAllPages
                                  ? const SizedBox()
                                  : Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: const CircularProgressIndicator(),
                                    ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
