import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:house_booking/models/user.dart';
import 'package:path/path.dart';

import '../api.dart';

class AuthApi {
  late Box<String> box;
  late Box<String> idBox;

  String? apiToken;

  User? user;

  bool get isLogin => apiToken != null;

  Future<void> init() async {
    box = await Hive.openBox<String>('token'); // Creation box and OPen it
    idBox = await Hive.openBox<String>('id'); // Creation box and OPen it
  }

  Future<void> signUp(
      {required String username,
      required String email,
      required String password,
      required String userType}) async {
    String url = '$baseUrl/user/signUp/';

    Response response = await dio.post(url, data: {
      'email': email,
      'username': username,
      'password': password,
      'userType': userType
    });

    apiToken = response.data['token'];
    await saveToken(token: apiToken!);
    await saveId(id: response.data['id']);
  }

  Future<void> signIn({required String email, required String password}) async {
    print("the password is $password and$email the email is ") ;
    String url = '$baseUrl/user/signIn';

    Response response =
        await dio.post(url, data: {"email": email, "password": password});
    apiToken = response.data['token'];
    await saveToken(token: apiToken!);
    await saveId(id: response.data['id']);
  }

  Future<void> signOut() async {
    await box.clear();
    apiToken = null;
    user = null;
  }

  Future<User> getInfoUser({String? userId}) async {
    String? id = userId ?? getId();
    String url = '$baseUrl/user/$id';
    options = Options(headers: {
      // we must have the apitoken so we will check it later ( get the apitoken )
      'Authorization': 'Bearer $apiToken',
    });
    Response response = await dio.get(url, options: options).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        throw DioError(
          type: DioErrorType.connectTimeout,
          error: 'internet connection !!',
          requestOptions: RequestOptions(path: ''),
        );
        // throw Exception('Check your internet connection !!');
      },
    );
    user = User.fromMap(response.data) ;
    return user! ;
  }

  Future<bool> updateUserInfo(User user) async {
    String? id = getId();
    String url = '$baseUrl/user/$id';
    Map<String, dynamic> userData = user.toJson();
    if (userData['picture'] != null) {
      userData['picture'] = await MultipartFile.fromFile(
        (userData['picture'] as File).path,
        filename: basename((userData['picture'] as File).path),
      );
    }
    final FormData formData = FormData.fromMap(userData);
    Response response = await dio.post(url, data: formData).onError<DioError>(
      (error, stackTrace) {
        // print(error.response.data);
        throw error;
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      print("the error was in ${response.statusMessage}");
      return false;
    }

    return response.data['isUpdate'];
  }

  // in Hive when we try to get a data we don't need to put async/wait
  void getToken() {
    apiToken = box.get('token');
  }

  String? getId() => idBox.get('id');

  Future<void> saveToken({required String token}) async {
    // clear token
    await box.clear();
    await box.put('token', token);
  }

  Future<void> saveId({required String id}) async {
    await idBox.clear();
    await idBox.put('id', id);
  }
}
