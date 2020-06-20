import 'dart:io';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'presentation/pages/trip_page.dart';

import 'injector.dart' as di;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Inovola',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Cairo',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
              subtitle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              body1: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              body2: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
      ),
      home: TripPage(),
    );
  }
}
