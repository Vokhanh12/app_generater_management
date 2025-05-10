import 'package:app_generator_management/configs/app.dart';
import 'package:app_generator_management/core/app/app_dementions.dart';
import 'package:app_generator_management/core/constants/assets.dart';
import 'package:app_generator_management/core/constants/color.dart';
import 'package:app_generator_management/core/router/app_router.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _nextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRouter.ads,
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _nextScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.splashPng,
            fit: BoxFit.fitWidth,
          ),
          Positioned(
            bottom: AppDimensions.normalize(205),
            child: const CircularProgressIndicator(
              color: AppColors.deepTeal,
            ),
          ),
        ],
      ),
    );
  }
}
