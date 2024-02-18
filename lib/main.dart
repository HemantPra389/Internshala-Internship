import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internshala/core/constants.dart';
import 'package:internshala/dependency_injection.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:internshala/feature/main_app/domain/entities/internship_filter_entity.dart';
import 'package:internshala/feature/main_app/presentation/screens/main_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await init();
  await openHiveBoxes();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future openHiveBoxes() async {
  Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.openBox(AppConstants.profileBox);
  Hive.openBox(AppConstants.cityBox);
  Hive.openBox(AppConstants.durationBox);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainHomeScreen(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData()),
    );
  }
}
