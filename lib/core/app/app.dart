import 'package:app_generator_management/core/constants/color.dart';
import 'package:app_generator_management/core/constants/strings.dart';
import 'package:app_generator_management/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nibbles',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.splash,
      theme: ThemeData(
        fontFamily: AppStrings.fontFamily,
        scaffoldBackgroundColor: Color(0xFF1E1E2F),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateColor.resolveWith(
            (states) => AppColors.lightGrey,
          ),
        ),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: AppColors.commonAmber,
          headerBackgroundColor: AppColors.deepTeal,
        ),
      ),
    );
  }
}
