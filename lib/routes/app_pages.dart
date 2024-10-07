import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:texoworld_chat_task/module/auth/bindings/auth_binding.dart';
import 'package:texoworld_chat_task/module/auth/views/login_view.dart';
import 'package:texoworld_chat_task/module/home/bindings/home_binding.dart';
import 'package:texoworld_chat_task/module/home/views/home_view.dart';
import 'package:texoworld_chat_task/module/splash/bindings/splash_binding.dart';
import 'package:texoworld_chat_task/module/splash/views/splash_view.dart';
import 'package:texoworld_chat_task/routes/app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.splash;

  static final routes = [
    GetPage(
        name: AppRoutes.splash,
        page: () => SplashView(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoutes.login,
        page: () => LoginView(),
        binding: AuthBinding()),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomeView(),
        binding: HomeBinding()),
  ];
}
