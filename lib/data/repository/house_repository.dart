import 'package:dio/dio.dart';
import 'package:house_booking/models/City.dart';
import 'package:path/path.dart';

import '../../models/house.dart';
import '../../models/municipality.dart';
import '../../models/picture.dart';
import '../api/api.dart';
import '../api/house_api.dart';

class HouseRepository {
  // here we make dependency injection
  HouseApi houseApi = HouseApi();

  Future<List<House>> getHouse(String? cityId , String? userId) async {
    List<Map<String, dynamic>>? data = await houseApi.getHouse(cityId: cityId,userId: userId);
    List<House> houses = [];

    for (var element in data!) {
      houses.add(House.fromMap(element));
    }
    return houses;
  }

  Future<House?> createHouse(House house) async {
    Map<String, dynamic> data = house.toJson();
    for (int i = 0; i < house.pictures.length; i++) {
      MultipartFile multipartFile = await MultipartFile.fromFile(
        house.pictures[i].picture,
        filename: basename(house.pictures[i].picture),
      );
      data['pictures'].add({'picture': multipartFile});
    }
    // here we put ListFormat.multiCompatible  cause is the solution to add array in form data.
    FormData format = FormData.fromMap(data, ListFormat.multiCompatible);

    Map<String, dynamic>? responseData =
        await houseApi.createHouse(data: format);

    if (responseData != null) {
      House response = House.fromMap(responseData);
      return response;
    }
    return null;
  }

  Future<House> getHouseInfo(String? houseId) async {
    Map<String, dynamic>? data = await houseApi.houseInfo(houseId: houseId);
    House? house = House.fromMap(data!);
    return house;
  }

  Future<void> deleteHouse(String houseId) async {
    await houseApi.houseInfo(houseId: houseId, methode: Methode.DELETE);
  }

  Future<House?> updateHouse(
      {required String id,
      required House data,
      List<Picture> deletePic = const []}) async {
    Map<String, dynamic> house = data.toJson();
    house['pictures'] = [];

    for (int i = 0; i < data.pictures.length; i++) {
      MultipartFile multipartFile = await MultipartFile.fromFile(
        data.pictures[i].picture,
        filename: basename(data.pictures[i].picture),
      );
      house['pictures'].add({'picture': multipartFile});
    }
    if (deletePic.isNotEmpty) {
      try {
        for (int i = 0; i < deletePic.length; i++) {
          await houseApi.deletePicture(id: deletePic[i].id!);
        }
      } on DioError catch (e) {
        print(e.response?.data);
      }
    }

    FormData formdata = FormData.fromMap(house, ListFormat.multiCompatible);

    Map<String, dynamic>? responseData = await houseApi.houseInfo(
      houseId: id,
      methode: Methode.PATCH,
      data: formdata,
    );
    if (responseData != null) {
      House response = House.fromMap(responseData);
      return response;
    }
    return null;
  }

  Future<List<City>?> getCities() async {
    List<Map<String, dynamic>>? data = await houseApi.getCities();

    List<City> cities = [];
    data?.forEach((element) {

      cities.add(City.fromMap(element));

    });

    return cities;
  }
  Future<List<Municipality>?> getMunicipalities({String cityId = ''}) async {
    List<Map<String, dynamic>>? data = await houseApi.getMunicipalities(
      cityId: cityId,
    );
    List<Municipality> municipalities = [];
    data?.forEach((element) {
      municipalities.add(Municipality.fromMap(element));
    });

    return municipalities;
  }
}
