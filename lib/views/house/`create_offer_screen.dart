import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_booking/views/house/house_details_view.dart';

import '../../components/custom_app_bar.dart';
import '../../components/text_fiel_with_title.dart';
import '../../constants/constant.dart';
import '../../controllers/controller.dart';
import '../../models/house.dart';
import '../../models/offer.dart';

class CreateOfferScreen extends StatefulWidget {
  CreateOfferScreen({
    Key? key,
    required this.house,
    this.offer,
    this.isUpdate = false,
  }) : super(key: key);
  House house;
  Offer? offer;
  bool isUpdate;

  @override
  State<CreateOfferScreen> createState() => _CreateOfferScreenState();
}

class _CreateOfferScreenState extends State<CreateOfferScreen> {
  Offer? offer;

  RxInt pricePerDay = 0.obs;

  RxBool isLoading = false.obs;

  var pricePerDayKey = GlobalKey<FormState>(
    debugLabel: 'pricePerDayKey',
  );

  TextEditingController? pricePerDayController;

  @override
  void initState() {
    pricePerDayController = TextEditingController(
      text: widget.isUpdate ? widget.offer?.pricePerDay.toString() : '0',
    );
    offer = Offer(
      house: widget.house,
      status: statusPublished,
    );
    pricePerDay.value = int.parse(pricePerDayController!.text);

    pricePerDayController?.addListener(() {
      try {
        pricePerDay.value = int.parse(pricePerDayController!.text);
      } catch (e) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(
                    title: 'New Offer',
                    backButton: true,
                    trailing: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: const Text(
                        'Publish',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        isLoading.value = true;
                        try {
                          print(offer?.status);
                          if (pricePerDayKey.currentState?.validate() ??
                              false) {
                            if (widget.isUpdate) {
                              await offerController.updateOfferInfo(
                                offerId: widget.offer!.id!,
                                offer: widget.offer!
                                  ..pricePerDay = pricePerDay.value
                                  ..status = statusPublished,
                              );
                              print('the value that is was updating is ${widget.offer!.pricePerDay} and the statue is ${widget.offer!.status} ') ;
                            } else {
                              await offerController.createOffer(
                                offer!..pricePerDay = pricePerDay.value,
                              );

                            }
                            await offerController
                                .refreshData(widget.house.id);
                            print(' the create offer is done ');
                            Get.back();
                          }
                        } catch (e) {}
                        isLoading.value = false;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: Column(
                      children: [
                        SizedBox(height: Get.height * 0.02),
                        TextFielWithTitle(
                          formKey: pricePerDayKey,
                          controller: pricePerDayController!,
                          textInputType: TextInputType.number,
                          title: 'Price per day',
                          validator: (value) {
                            if (pricePerDayController!.text.isEmpty) {
                              return 'You must fill in this field';
                            }
                            if (double.parse(pricePerDayController!.text) ==
                                0) {
                              return 'You have to change this field';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  Center(
                    child: Container(
                      height: Get.height * 0.75,
                      width: Get.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: deepPrimaryColor.withOpacity(0.5),
                        ),
                      ),
                      child: Obx(
                        () => HouseDetailsView(
                          offer: offer!..pricePerDay = pricePerDay.value,
                          isPreview: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => isLoading.value
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
}
