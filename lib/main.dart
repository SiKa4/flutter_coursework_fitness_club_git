import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizing/sizing_builder.dart';
import 'HTTP_Connections/http_model.dart';
import 'Pages/auth.dart';
import 'Pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? id_User = prefs.getInt('UserId');
  Intl.systemLocale = 'ru';
  initializeDateFormatting('ru');
  HttpOverrides.global = ApiService();
  if (id_User != -1 && id_User != null) {
    ApiService.user = await ApiService().getUserById(id_User);
    ApiService.login = await ApiService().getLoginsByIdUser(id_User);
  }
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyThemeApp());
  });
}

class MyThemeApp extends StatelessWidget {
  const MyThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Landing(),
          '/home': (context) => const HomePageUser(),
        },
      ),
    );
  }
}

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return ApiService.user != null ? const HomePageUser() : const AuthPage();
  }
}
