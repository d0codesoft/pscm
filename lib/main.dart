import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pscm/core/database.dart';
import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';
import 'package:pscm/screens/login_app.dart';

import 'components/qrCodeScaner.dart';
import 'core/app_theme.dart';
import 'screens/edit_server_connect_screen.dart';
import 'screens/home_screen.dart';
import 'core/utils/appHttpOverrides.dart';

final _logger = Logger('pscm');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;
  PrintAppender.setupLogging(stderrLevel: Level.ALL);

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
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
      routes: [
          GoRoute(
            path: 'server',
            builder: (context, state) => EditServerScreen(),
            routes: [
              GoRoute(
                  path: 'scanQrCode',
                  builder: (context, state) => QrCodeScannerPage(),
              ),
            ]
          ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginApp(),
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