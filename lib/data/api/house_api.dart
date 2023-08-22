import 'dart:convert';

import 'package:dio/dio.dart';

import 'api.dart';

class HouseApi {
  Future<List<Map<String, dynamic>>?> getHouse({String? cityId ,String? userId}) async {
    String apiUrl = '$baseUrl/houses/fetch_house';
    if (cityId != null) apiUrl += '/city/$cityId/';
    if (userId != null) apiUrl += '/user/$userId/';

    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        // print(error.response.data);
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }
    final List<Map<String, dynamic>> houses = [...response.data['data']];
    return houses;
  }

  Future<String?> createHouse({FormData? data}) async {
    String url = '$baseUrl/houses/create_house';

    Response response = await dio
        .post(
      url,
      data: data,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
         print('the error while we create house is ${error.response!.data}');
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }

    return 'Data was created';
  }

  Future<Map<String, dynamic>?> houseInfo(
      {String? houseId, Methode methode = Methode.GET, FormData? data}) async {
    String url = '$baseUrl/houses/update_house/$houseId';
    Response? response;

    switch (methode) {
      case Methode.DELETE:
        response = await dio.delete(url, options: options).onError<DioError>(
          (error, stackTrace) {
            throw error;
          },
        );
        break;
      case Methode.PATCH:
        print('the Patch methode was running') ;
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

  Future<List<Map<String, dynamic>>?> getCities() async {
    String apiUrl = '$baseUrl/houses/city';

    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
       //  print("the error was in ${error.response?.data}");
        throw error;
      },
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }

    final List<Map<String, dynamic>>? cities = [...response.data['cities']];
    print("the size is ${cities?.length}");
    return cities;
  }

  Future<Response?> deletePicture({String? id}) async {
    print('the api methode delete was called ') ;
    String apiUrl = '$baseUrl/houses/picture/$id';

    Response? response = await dio
        .delete(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
      (error, stackTrace) {
        // print(error.response.data);
        throw error;
      },
    );
    return response;
  }

  Future<List<Map<String, dynamic>>?> getMunicipalities({
    String cityId = '',
  }) async {
    String apiUrl = '$baseUrl/houses/api/municipalities/$cityId';

    Response response = await dio
        .get(
      apiUrl,
      options: options,
    )
        .onError<DioError>(
          (error, stackTrace) {
        // print(error.response.data);
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response);
    }

    return [...response.data['municipality']];
  }


}
