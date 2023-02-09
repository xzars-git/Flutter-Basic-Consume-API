import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:exam/assets/image.dart';
import 'package:exam/controller/auth_controller.dart';
import 'package:exam/screen/home.dart';
import 'package:exam/screen/signUp.dart';
import 'package:exam/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import './screen/login.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false, home: splashScreen());
  }
}
