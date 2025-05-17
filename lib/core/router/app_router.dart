import 'package:app_generator_management/presentation/sreens/dashboard.dart';
import 'package:app_generator_management/presentation/sreens/splash.dart';
import 'package:flutter/material.dart';

import '../error/exceptions.dart';

sealed class AppRouter {
  static const String splash = '/';
  static const String ads = '/ads';
  static const String dashbroad = '/dashbroad';
  static const String root = '/root';

  static const List<String> moreScreenTaps = [];

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case dashbroad:
        return MaterialPageRoute(builder: (_) => const DashboardSceen());

      default:
        throw const RouteException('Route not found!');
    }
  }
}
