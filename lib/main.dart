import 'package:app_generator_management/core/app/app.dart';
import 'package:app_generator_management/core/observer/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: '-',
    appId: '-',
    messagingSenderId: '-',
    projectId: '-',
    authDomain: '-',
    databaseURL: '-',
    storageBucket: '-',
    measurementId: '-',
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  Bloc.observer = NibblesBlocObserver();


  runApp(const MyApp());
}

