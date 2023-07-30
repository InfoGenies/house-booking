import 'package:get/get.dart';
import 'package:house_booking/models/City.dart';

import '../data/repository/house_repository.dart';
import '../models/house.dart';
import '../models/municipality.dart';
import '../models/picture.dart';

class HouseController extends GetxController with HouseRepository {
  static HouseController instance = Get.find<HouseController>();
  final String municipalitiesId = 'municipalitiesId';

  bool isLoading = true;
  bool isHouseLoading = true;

  List<City> cities = [];
  List<Municipality> municipalities = [];

  List<House> myHouses = [];

  bool get isEmpty => myHouses.isEmpty;

  @override
  void onInit() async {
    super.onInit();
    await getCity();
  }

  Future<void> getHouses(String? cityId, String? userId) async {
    myHouses.clear();
    isHouseLoading = false;
    myHouses.addAll(await super.getHouse(cityId, userId));
    update();
  }

  Future<void> getCity() async {
    isLoading = true;
    cities = (await super.getCities() ?? []);
    isLoading = false;
    update();
  }

  @override
  Future<void> deleteHouse(String houseId) async {
    await super.deleteHouse(houseId);
  }

  @override
  Future<House?> createHouse(House house) async {
    await super.createHouse(house);
    //   await refreshData(parameters: Parameters(myHouses: true));
    return null;
  }

  @override
  Future<House?> updateHouse(
      {required String id,
      required House data,
      List<Picture> deletePic = const []}) async {
    await super.updateHouse(
      id: id,
      data: data,
      deletePic: deletePic,
    );
    // await refreshData(parameters: Parameters(myHouses: true));
    return null;
  }

  @override
  Future<List<Municipality>?> getMunicipalities({String cityId = ''}) async {
    municipalities = (await super.getMunicipalities(cityId: cityId)) ?? [];
    update([municipalitiesId]);
    return municipalities;
  }
}
