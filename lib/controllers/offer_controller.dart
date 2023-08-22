import 'package:get/get.dart';

import '../constants/constant.dart';
import '../data/repository/offer_repository.dart';
import '../models/house.dart';
import '../models/offer.dart';

class OfferController extends GetxController with OfferRepository {
  static OfferController instance = Get.find();

  final String offerInfoWidgetId = 'offerInfoWidgetId';
  final String offersByHouseId = 'offerByHouseId';

  bool isGettingOfferByHouse = true;

  List<Offer> offers = [];

  List<Offer> offersByCity = [];

  List<Offer> offersByHouse = [];
  bool isLoading = false;
  bool isGetAllPages = false;

  bool get isEmpty => offers.isEmpty;

  Future<void> getOffers({
    String? cityId,
    String? houseId,
  }) async {
    isLoading = true;
    List<Offer>? result =
        await super.getOffer(cityId: cityId, houseId: houseId);
    if (cityId == null) {
      offers.addAll(result ?? []);
    } else {
      offersByCity.addAll(result ?? []);
    }
    isLoading = false;
    update();
  }

  Future<List<House>?> getOffersByHouse(String? houseId) async {
    offersByHouse = (await super.getOffer(houseId: houseId)) ?? [];
    offersByHouse = offersByHouse.reversed.toList();
    isGettingOfferByHouse = false;
    update();
    return null;
  }

  @override
  Future<Offer?> getOfferInfo(String offerId) async {
    Offer? offer = await super.getOfferInfo(offerId);
    return offer;
  }

  Offer? get offerWithPublishStatus => offersByHouse.firstWhere(
        (offer) =>
            offer.status == statusPublished ||
            offer.status == statusWaittingForAccepte,
      );

  @override
  Future<void> createOffer(Offer offer) async {
    await super.createOffer(offer);
  }

  Future<void> refreshData(String? houseId) async {
    offersByHouse.clear();
    isGettingOfferByHouse = true;
    update();
    Future.delayed(const Duration(seconds: 1), () async {
      await getOffersByHouse(houseId);
    });
  }

  @override
  Future<void> updateOfferInfo({
    required String offerId,
    required Offer offer,
  }) async {
    await super.updateOfferInfo(
      offerId: offerId,
      offer: offer,
    );


  }

}
