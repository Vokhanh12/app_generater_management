import 'package:app_generator_management/application/bloc/auth/auth_bloc.dart';
import 'package:app_generator_management/application/bloc/category_genarator_management/generator_telemetry_bloc.dart';
import 'package:app_generator_management/application/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:app_generator_management/core/constants/color.dart';
import 'package:app_generator_management/core/constants/strings.dart';
import 'package:app_generator_management/core/router/app_router.dart';
import 'package:app_generator_management/repositories/auth_repo/auth_repo.dart';
import 'package:app_generator_management/repositories/category_genrator_repo/generator_telemytry_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => GeneratorTelemetryRepository(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
              firebaseAuth: FirebaseAuth.instance,
              firestore: FirebaseFirestore.instance),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(InitializeAuthEvent()),
          ),
          BlocProvider(
            create: (context) =>
                SignInBloc(authRepository: context.read<AuthRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Nibbles',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: AppRouter.splash,
          theme: ThemeData(
            fontFamily: AppStrings.fontFamily,
            scaffoldBackgroundColor: Color(0xFFEFF3F7),
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
        ),
      ),
    );
  }
}
