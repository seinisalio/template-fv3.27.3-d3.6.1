import 'dart:io';

import 'package:flutter/material.dart';

import 'app.dart';
import 'core/api/api.dart';
import 'core/env.dart';
import 'core/local_storage/database.dart';
import 'core/local_storage/secure_storage.dart';
import 'core/local_storage/shared_preferences.dart';
import 'core/logger.dart';

// TODO Supprimer cette logique avant mise en production
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async{
  //
  WidgetsFlutterBinding.ensureInitialized();

  // Certificat auto signé
  HttpOverrides.global = MyHttpOverrides();

  // Initialiser firebase si necessaire
  
  await AppLogger.init();
  // 
  await AppEnv.init();
  //
  await AppSecureStorage.init();
  //
  await AppSharedPreferences.init();
  //
  await AppDatabase.init();
  //
  await Api.init();
  // Run the app
  runApp(const App());
}