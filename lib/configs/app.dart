import 'package:app_generator_management/configs/app_typography.dart';
import 'package:app_generator_management/configs/space.dart';
import 'package:app_generator_management/core/app/app_dementions.dart';
import 'package:app_generator_management/core/app/ui.dart';
import 'package:flutter/material.dart';

class App {
  static bool? isLtr;

  static init(BuildContext context) {
    UI.init(context);
    AppDimensions.init();
    Space.init();
    AppText.init();
    isLtr = Directionality.of(context) == TextDirection.ltr;
  }
}
