import 'package:dio/dio.dart';

import '../../models/house.dart';
import 'api.dart';

class OfferAPI {
  Future<List<Map<String, dynamic>>?> getOffers({
    int? cityId,
    int? houseId,
  }) async {
    String apiUrl = '$baseUrl/houses/fetch_offers/';

    if (cityId != null) apiUrl += 'city/$cityId/';
    if (houseId != null) apiUrl += 'house/$houseId/';

    Response response =
        await dio.get(apiUrl, options: options).onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return [...response.data['offers']];
  }

  Future<House> getHouse(String houseId, String apiToken) async {

    String apiUrl = '$baseUrl/houses/house/$houseId';

    options = Options(headers: {
      // we must have the apitoken so we will check it later ( get the apitoken )
      'Authorization': 'Bearer $apiToken',
    });

    Response response =
        await dio.get(apiUrl, options: options).onError<DioError>(
      (error, stackTrace) {
        print("th error was ${error.toString()}");
        throw error;
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("the house is ${response.data['data']}") ;
      return House.fromMap(response.data['data']);
    } else {
      throw Exception('Failed to get house');
    }
  }

  Future<Map<String, dynamic>?> createOffer(FormData data) async {
    String apiUrl = '$baseUrl/houses/create_offer/';

    Response response = await dio
        .post(
      apiUrl,
      data: data,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return response.data;
  }

  Future<Map<String, dynamic>?> offerInfo(
    int offerId, {
    Methode method = Methode.GET,
    FormData? data,
  }) async {
    String url = '$baseUrl/houses/offers/$offerId/';

    Response? response;
    switch (method) {
      case Methode.DELETE:
        response = await dio.delete(url, options: options).onError<DioError>(
          (error, stackTrace) {
            throw error;
          },
        );
        break;
      case Methode.PATCH:
        response = await dio
            .patch(url, data: data, options: options)
            .onError<DioError>(
          (error, stackTrace) {
            throw error;
          },
        );
        break;
      default:
        response = await dio.get(url, options: options).onError<DioError>(
          (error, stackTrace) {
            throw error;
          },
        );
        break;
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }

    return response.data;
  }

  Future<Map<String, dynamic>?> changeStatus({
    required int offerId,
    required String status,
  }) async {
    String apiUrl = '$baseUrl/houses/offers/status/$offerId/';

    Map<String, dynamic> data = {'status': status};

    Response response = await dio
        .patch(
      apiUrl,
      data: data,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }

    return response.data;
  }

  Future<List<Map<String, dynamic>>?> search({
    int page = 1,
    String? search,
    int? cityId,
    String? orderBy,
    bool inversOrdering = false,
  }) async {
    String apiUrl = '$baseUrl/houses/api/offers/search/';
    apiUrl += '?page=$page';

    if (search != null) apiUrl += '&search=$search';
    if (cityId != null) apiUrl += '&city=$cityId';
    if (orderBy != null) {
      if (inversOrdering) orderBy = '-$orderBy';
      apiUrl += '&order_by=$orderBy';
    }

    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    return [...response.data['results']];
  }
}
