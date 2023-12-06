import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pscm/core/database.dart';

import 'core/app_theme.dart';
import 'screens/home_screen.dart';
import 'core/utils/appHttpOverrides.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = AppHttpOverrides();
  var db = DBProvider.instance;
  db.initDB();

  /*await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(const PSCMApp()));*/
  runApp(const PSCMApp());
}

final routeData = [
  //RouteItem(
  //  name: l10n.editServerNameRoute,
  //  route: 'editserver',
  //  builder: (context) => EditServerScreen(),
  //)
];

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        for (final routeItem in routeData)
          GoRoute(
            path: routeItem.route,
            builder: (context, state) => routeItem.builder(context),
          ),
      ],
    ),
  ],
);


class PSCMApp extends StatelessWidget {
  const PSCMApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
/*
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
*/
    return MaterialApp.router(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('uk'), // Ukraine
      ],
      title: 'Power server control',
      theme : ThemeData(
          primaryColor: AppTheme.primaryColorTheme,
          primarySwatch: AppTheme.appcolor
      ),
      routerConfig: router
    );
  }
}