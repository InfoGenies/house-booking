import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../components/Blur_Widget.dart';
import '../../components/custom_app_bar.dart';
import '../../components/description_viewer.dart';
import '../../components/map_apps.dart';
import '../../components/pictures_slider.dart';
import '../../components/rating_widget.dart';
import '../../components/rooms_number_widget.dart';
import '../../components/stars_widget.dart';
import '../../components/submit_button.dart';
import '../../components/title_widget.dart';
import '../../constants/constant.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/controller.dart';
import '../../controllers/favorite_controller.dart';
import '../../controllers/offer_controller.dart';
import '../../data/api/api.dart';
import '../../models/chat_item_model.dart';
import '../../models/offer.dart';
import '../../models/picture.dart';
import '../chat/chat_view.dart';

class HouseDetailsView extends StatefulWidget {
  Offer offer;

  bool isPreview;

  HouseDetailsView({Key? key, required this.offer, this.isPreview = false})
      : super(key: key);

  @override
  State<HouseDetailsView> createState() => _HouseDetailsViewState();
}

class _HouseDetailsViewState extends State<HouseDetailsView> {
  ScrollController scrollController = ScrollController();

  EdgeInsets margin = EdgeInsets.symmetric(
    horizontal: Get.width * 0.03,
    vertical: Get.height * 0.01,
  );

  GlobalKey startChattingButton = GlobalKey();

  RxDouble startChattingButtonHeight = 0.0.obs;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((d) {
      try {
        startChattingButtonHeight.value = (startChattingButton.currentContext
                ?.findRenderObject() as RenderBox)
            .size
            .height;
      } catch (e) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            widget.isPreview
                ? const CustomAppBar(title: 'Preview')
                : CustomAppBar(
                    title: 'House',
                    backButton: true,
                    trailing: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: GetBuilder<FavoriteController>(
                        id: favoriteController.favoriteIconId,
                        builder: (context) {
                          // this is juste to test the dependency injection
                          print(' the rebuild widget ');

                          return Icon(
                            favoriteController.contains(widget.offer.id!)
                                ? Icons.favorite_rounded
                                : Icons.favorite_border,
                            color: favoriteController.contains(widget.offer.id!)
                                ? primaryColor
                                : deepPrimaryColor,
                          );
                        },
                      ),
                      onTap: () async {
                        if (widget.offer.id != null) {
                          await favoriteController.addFavorites(
                              widget.offer.id!, authController.getId()!);
                        }
                      },
                    ),
                  ),
            Expanded(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      if (!widget.isPreview) {
                        /* offerController.getOfferInfo(widget.offer.id!,
                            returnOffer: (ofr) {
                          widget.offer = ofr;
                        });*/
                      }
                    },
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: GetBuilder<OfferController>(
                          id: offerController.offerInfoWidgetId,
                          builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.03,
                                    vertical: Get.height * 0.02,
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    widget.offer.house.title ?? '',
                                    style: Get.theme.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                PicturesSlider(
                                  pictures: widget
                                          .offer.house.pictures.isNotEmpty
                                      ? widget.offer.house.pictures
                                      : [
                                          Picture(
                                            picture: 'assets/vectors/house.svg',
                                            id: null,
                                          )
                                        ],
                                ),
                                SizedBox(height: Get.height * 0.03),
                                Container(
                                  margin: margin,
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            widget.offer.house.owner?.picture !=
                                                    null
                                                ? NetworkImage(baseUrl +
                                                    widget.offer.house.owner!
                                                        .picture!)
                                                : null,
                                        radius: Get.width * 0.07,
                                        child:
                                            widget.offer.house.owner?.picture ==
                                                    null
                                                ? SvgPicture.asset(
                                                    'assets/vectors/person.svg',
                                                  )
                                                : null,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        widget.offer.house.owner?.username ??
                                            '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      StarsWidget(
                                        stars: widget.offer.house.stars ?? 0,
                                        numReviews:
                                            widget.offer.house.numReviews ?? 1,
                                        type: StarsWidgetType.digital,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: margin,
                                  child: RoomsNumberWidget(
                                    kitchens: widget.offer.house.kitchens ?? 1,
                                    bathrooms:
                                        widget.offer.house.bathrooms ?? 1,
                                    bedrooms: widget.offer.house.bedrooms ?? 1,
                                    color: Colors.black54,
                                    size: 25,
                                    textStyle:
                                        Get.theme.textTheme.headlineSmall,
                                  ),
                                ),
                                Container(
                                  margin: margin,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          print('this line was taped ');
                                          if (widget.offer.house
                                                      .locationLatitude !=
                                                  null &&
                                              widget.offer.house
                                                      .locationLongitude !=
                                                  null) {
                                            Get.bottomSheet(
                                              MapApps(
                                                coords: Coords(
                                                  widget.offer.house
                                                      .locationLatitude!,
                                                  widget.offer.house
                                                      .locationLongitude!,
                                                ),
                                              ),
                                              elevation: 0,
                                              barrierColor: Colors.transparent,
                                            );
                                          }
                                        },
                                        child: Row(
                                          children: const [
                                            FaIcon(
                                              FontAwesomeIcons.locationDot,
                                              color: primaryColor,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Open Map',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          widget.offer.pricePerDay.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        'DA/Day',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TitleWidget(
                                  title: 'Description:',
                                  margin: margin.copyWith(
                                    bottom: 0,
                                    top: Get.height * 0.04,
                                  ),
                                  textStyle: Get.textTheme.titleLarge?.copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  margin: margin,
                                  child: DescriptionViewer(
                                      text:
                                          widget.offer.house.description ?? ''),
                                ),
                                const SizedBox(),
                                Obx(
                                  () => SizedBox(
                                    height: startChattingButtonHeight.value,
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  widget.isPreview ||
                          widget.offer.house.owner!.id == authController.getId()
                      ? const SizedBox()
                      : Positioned(
                          width: Get.width,
                          bottom: 0,
                          child: BlurWidget(
                            child: Center(
                              child: SubmitButton(
                                key: startChattingButton,
                                text: 'Start Chatting',
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 25,
                                ),
                                onTap: () => Get.to(
                                  () => ChatView(
                                    chatItemModel: ChatItemModel(
                                      offer: widget.offer,
                                      user: Get.find<AuthController>().user,
                                    ),
                                  ),
                                  transition: Transition.downToUp,
                                ),
                              ),
                            ),
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
}
