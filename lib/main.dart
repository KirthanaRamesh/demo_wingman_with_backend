
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/get_started.dart';
import '../constants/app_strings.dart';
import '../view/app_home.dart';
import '../view/enter_otp.dart';
import '../view/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo Wingman',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: GetStarted(),
      getPages: [
        GetPage(name: '/', page: () => GetStarted()),
        GetPage(name: AppString.enterOtpRoute, page: () => EnterOTP()),
        GetPage(name: AppString.welcomeRoute, page: () => Welcome()),
        GetPage(name: AppString.appHomeRoute, page: () => AppHome())
      ],
    );
  }
}
