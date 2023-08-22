import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';
import '../controllers/offer_controller.dart';
import '../models/City.dart';
import 'empty_screen.dart';
import 'house_widget.dart';

class CityScreen extends StatefulWidget {
  City city;

  CityScreen({Key? key, required this.city}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  OfferController offerController = Get.find<OfferController>();
  ScrollController cityOffersScrollController = ScrollController();

  @override
  void initState() {
    offerController.isLoading = true ;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
          await offerController.getOffers(cityId: widget.city.id);

    });

    cityOffersScrollController.addListener(() {
      if ((cityOffersScrollController.position.maxScrollExtent * 0.8) <
          cityOffersScrollController.position.pixels) {
        //   offerController.getNextPage(parameters: parameters);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    cityOffersScrollController.dispose();
    offerController.offersByCity.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: NestedScrollView(
          controller: cityOffersScrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              expandedHeight: Get.height * 0.25,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.city.name ?? ''),
                centerTitle: true,
                titlePadding: EdgeInsets.only(
                  bottom: Get.height * 0.1,
                ),
                background: widget.city.picture != null
                    ? Hero(
                        tag: widget.city.id!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              opacity: 0.7,
                              image: NetworkImage(
                                widget.city.picture!,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              backgroundColor: primaryColor.withOpacity(0.3),
              elevation: 0,
              leading: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: const Icon(
                  Icons.arrow_back_ios,
                ),
                onTap: () => Get.back(),
              ),
            ),
          ],
          body: GetBuilder<OfferController>(
            builder: (context) {
              return offerController.offersByCity.isEmpty
                  ? offerController.isLoading
                      ? const HouseLoader()
                      : const Center(
                          child: EmptyScreen(
                            title: 'No Houses yet',
                            icon: FontAwesomeIcons.houseCircleExclamation,
                            isExpanded: false,
                          ),
                        )
                  : SizedBox(
                      height: double.infinity,
                      child: ListView.builder(
                        itemCount: offerController.offersByCity.length + 1,
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) => index !=
                                offerController.offersByCity.length
                            ? HouseWidget(
                                offer: offerController.offersByCity[index],
                              )
                            : offerController.isGetAllPages
                                ? const SizedBox()
                                : Container(
                                    alignment: Alignment.center,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: const CircularProgressIndicator(),
                                  ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
