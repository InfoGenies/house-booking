import 'package:get/get.dart';

import '../data/repository/offer_repository.dart';
import '../models/offer.dart';

class OfferController extends GetxController with OfferRepository {
  static OfferController instance = Get.find();

  final String offerInfoWidgetId = 'offerInfoWidgetId';

  List<Offer> offers = [];

  List<Offer> offersByCity = [];

  List<Offer> offersByHouse = [];
  bool isLoading = false;
  bool isGetAllPages = false;

  bool get isEmpty => offers.isEmpty;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getOffers();

  }

  Future<void> getOffers({
    int? cityId,
    int? houseId,
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

  @override
  Future<Offer?> getOfferInfo(int offerId) async {
    Offer? offer = await super.getOfferInfo(offerId);
    return offer;
  }
}
