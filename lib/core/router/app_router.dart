import 'package:app_generator_management/presentation/sreens/splash.dart';
import 'package:flutter/material.dart';

import '../error/exceptions.dart';

sealed class AppRouter {
  static const String splash = '/';
  static const String ads = '/ads';
  static const String root = '/root';

  static const List<String> moreScreenTaps = [];

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
        throw const RouteException('Route not found!');
    }
  }
}
