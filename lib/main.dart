import 'package:app_generator_management/core/app/app.dart';
import 'package:app_generator_management/core/observer/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: FirebaseOptions(
    apiKey: 'AIzaSyDS6J-ecyEIqxKauCXqoH_OHM_u4G0OKDE',
    appId: '1:697316737966:web:ac47a543b29ead691d3e3f',
    messagingSenderId: '697316737966',
    projectId: 'app-genertor-mg',
    authDomain: 'app-genertor-mg.firebaseapp.com',
    databaseURL: 'https://app-genertor-mg-default-rtdb.firebaseio.com/',
    storageBucket: 'app-genertor-mg.firebasestorage.app',
    measurementId: 'G-NG8E4Z5WW0',
  ));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  Bloc.observer = NibblesBlocObserver();


  runApp(const MyApp());
}

