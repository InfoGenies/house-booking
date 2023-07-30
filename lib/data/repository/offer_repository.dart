import 'package:dio/dio.dart';
import 'package:house_booking/data/api/api.dart';
import 'package:house_booking/models/offer.dart';

import '../api/offer_api.dart';

class OfferRepository {
  OfferAPI offerAPI = OfferAPI();

  Future<List<Offer>?> getOffer({
    int? cityId,
    int? houseId,
  }) async {
    List<Map<String, dynamic>>? data =
        await offerAPI.getOffers(houseId: houseId, cityId: cityId);
    List<Offer> offers = [];

    for (var element in data!) {
      offers.add(Offer.fromMap(element));
    }
    return offers;
  }

  Future<Offer?> getOfferInfo(int offerId) async {
    Map<String, dynamic>? data = await offerAPI.offerInfo(offerId);
    return Offer.fromMap(data!);
  }

  Future<Offer?> createHouse(Offer offer) async {
    FormData data = FormData.fromMap(offer.toJson());
    Map<String, dynamic>? responseData = await offerAPI.createOffer(data);
    if (responseData != null) {
      Offer responseOffer = Offer.fromMap(responseData);
      return responseOffer;
    }
    return null;
  }

  Future<Offer?> updateOfferInfo(
      {required int offerId, required Offer offer}) async {
    FormData data = FormData.fromMap(offer.toJson());
    Map<String, dynamic>? response =
        await offerAPI.offerInfo(offerId, data: data, method: Methode.PATCH);
    if (response != null) {
      Offer responseData = Offer.fromMap(response);
      return responseData;
    }
    return null;
  }

  Future<Map<String, dynamic>?> changeStatus({
    required int offerId,
    required String status,
  }) async {
    Map<String, dynamic>? data =
        await offerAPI.changeStatus(offerId: offerId, status: status);

    return data;
  }

  Future<List<Offer>?> search({
    int page = 1,
    String? search,
    int? cityId,
    String? orderBy,
    bool inversOrdering = false,
  }) async {
    List<Map<String, dynamic>>? data = await offerAPI.search(
      page: page,
      cityId: cityId,
      search: search,
      orderBy: orderBy,
      inversOrdering: inversOrdering,
    );
    List<Offer> offers = [];
    data?.forEach((element) {
      offers.add(Offer.fromMap(element));
    });

    return offers;
  }
}
