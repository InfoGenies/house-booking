import 'package:dio/dio.dart';
import 'package:house_booking/data/api/api.dart';

class RatingApi {

  Future<List<Map<String, dynamic>>?> getHouseRatings({
    required String houseId,
    int page = 1,
  }) async {
    String apiUrl = '$baseUrl/houses/fetch_rating/$houseId';

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

  Future<Map<String, dynamic>?> ratingOnHouse({
    required FormData data,
  }) async {
    String apiUrl = '$baseUrl/houses/create_rating';

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
}