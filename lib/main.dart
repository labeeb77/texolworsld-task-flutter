import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texoworld_chat_task/module/splash/bindings/splash_binding.dart';
import 'package:texoworld_chat_task/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat Works',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppPages.routes,
      initialBinding: SplashBinding(),
      initialRoute: AppPages.INITIAL,

    );
  }
}
