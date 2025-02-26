import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLogger{

  static final logger = Logger();

  AppLogger._();

  static Future<void> init() async {
    // Pour ne pas polluer les dashboards de crashlytics en mode debug
    // await FirebaseCrashlytics.instance
    //     .setCrashlyticsCollectionEnabled(kDebugMode ? false : true);

    // Pour écouter sur les erreurs de flutter et les envoyer vers Crashlytics
    // = FirebaseCrashlytics.instance.recordFlutterFatalError;
    FlutterError.onError = (details) {
      //FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      FlutterError.presentError(details);
      //if (kReleaseMode) exit(1);
    };

    // Transmettre toutes les erreurs asynchrones non détectées
    // qui ne sont pas gérées par le framework Flutter à Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      //FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  //
  static void info(dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }){
    logger.log(Level.info, message, time: time, error: error, stackTrace: stackTrace);
  }
  //
  static void error(dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }){
    logger.log(Level.error, message, time: time, error: error, stackTrace: stackTrace);
  }
  //
  static void warning(dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }){
    logger.log(Level.warning, message, time: time, error: error, stackTrace: stackTrace);
  }
  //
  static void fatal(dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }){
    logger.log(Level.fatal, message, time: time, error: error, stackTrace: stackTrace);
  }
  //
  static void debug(dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }){
    logger.log(Level.debug, message, time: time, error: error, stackTrace: stackTrace);
  }
}