import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/demo/ui/pages/demo_page.dart';
import '../../modules/settings/ui/settings_page.dart';
import '../../shared/widgets/error_404.dart';
import '../logger.dart';

class AppRouter {
  //-------------- DEMO ------------//
  static const demo = "/demo";
  //-------------- SETTING ------------//
  static const settings = "/settings";
  
  AppRouter._();

  /// Méthode qui retourne la configuration des routes
  //-------------- ---------------------- ------------//
  //-------------- ---- PAGES ROUTES ---- ------------//
  //-------------- ---------------------- ------------//
  static GoRouter routes(String initial) {
    AppLogger.info('Route initiale $initial');

    return GoRouter(
      initialLocation: initial,
      errorPageBuilder: (context, state) => const MaterialPage(
        child: NotFoundPage(),
      ),
      routes: [
        //-------------- DEMO ------------//
        ..._demoRoute(),
        //-------------- SETTINGS ------------//
        ..._settingsRoute(),
      ],
    );
  }

  //-------------- DEMO ROUTE ------------//
  static List<RouteBase> _demoRoute(){
    return [
      GoRoute(
        path: demo,
        builder: (context, state) => const DemoPage(),
      ),
    ];
  }

  //-------------- DEMO ROUTE ------------//
  static List<RouteBase> _settingsRoute(){
    return [
      GoRoute(
        path: settings,
        builder: (context, state) => const SettingsPage(),
      ),
    ];
  }

  //-------------- ---------------------- ------------//
  //-------------- --- PAGE NAGIVATION -- ------------//
  //-------------- ---------------------- ------------//

  /// Permet de naviguer entre les pages
  static Future<T?> push<T>(
    BuildContext context,
    String route, {
    Object? params,
  }) async {
    return await context.push(route, extra: params);
  }

  /// Permet de naviguer entre les pages avec impossibilité de revennir en sur la page precedante
  static void pushReplacement(
    BuildContext context,
    String route, {
    Object? params,
  }) async {
    context.pushReplacement(route, extra: params);
  }

  /// Fermer une page
  static void back(BuildContext context, {Object? value}) {
    context.pop(value);
  }

  /// Fermer un dialogue
  static void pop(BuildContext context, {Object? value}) {
    context.pop(value);
  }
}