import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:house_booking/views/splash_screen.dart';

import 'helpers/binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();// bind between frameworke(Widget) and Engine(hard material)
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      home:  Scaffold(
        body: SplashScreen(),
      )
    );
  }
}

