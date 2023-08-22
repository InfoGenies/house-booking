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

  Future<List<House>> getHouse(String? cityId, String? userId) async {
    List<Map<String, dynamic>>? data =
        await houseApi.getHouse(cityId: cityId, userId: userId);
    List<House> houses = [];

    for (var element in data!) {
      houses.add(House.fromMap(element));
    }
    return houses;
  }

  Future<String?> createHouse(House house) async {
    List<MultipartFile> pictureFiles = [];
    for (int i = 0; i < house.pictures.length; i++) {
      MultipartFile multipartFile = await MultipartFile.fromFile(
        house.pictures[i].picture,
        filename: basename(house.pictures[i].picture),
      );
      pictureFiles.add(multipartFile);
    }
    Map<String, dynamic> houseData = house.toJson();

    houseData['picture'] = pictureFiles;

    FormData formData = FormData.fromMap(houseData);

    String? responseData = await houseApi.createHouse(data: formData);

    if (responseData != null) {
      return responseData;
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

  Future<String?> updateHouse(
      {required String id,
      required House data,
      List<Picture> deletePic = const []}) async {
    List<MultipartFile> pictureFiles = [];

    for (int i = 0; i < data.pictures.length; i++) {
      if (!data.pictures[i].isUrl) {
        MultipartFile multipartFile = await MultipartFile.fromFile(
          data.pictures[i].picture,
          filename: basename(data.pictures[i].picture),
        );
        pictureFiles.add(multipartFile);
      }
    }

    Map<String, dynamic> houseData = data.toJson();
    houseData['picture'] = pictureFiles;
    if (deletePic.isNotEmpty) {
      try {
        for (int i = 0; i < deletePic.length; i++) {
          await houseApi.deletePicture(id: deletePic[i].id!);
        }
      } on DioError catch (e) {
        print(e.response?.data);
      }
    }

    FormData formData = FormData.fromMap(houseData);

    Map<String, dynamic>? responseData = await houseApi.houseInfo(
      houseId: id,
      methode: Methode.PATCH,
      data: formData,
    );
    if (responseData != null) {
      return 'The Data Is Updated';
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
