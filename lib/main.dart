import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HTTP_Connections/http_model.dart';
import 'Pages/auth.dart';
import 'Pages/home.dart';
import 'Pages/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int? id_User = prefs.getInt('UserId');
  if (id_User != null) {
    ApiService.user = ApiService().getUserById(id_User);
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: ApiService.user != null ? '/home' : '/',
      routes: {
        '/': (context) => const AuthPage(),
        '/home': (context) => const HomePageUser()
      },
    );
  }
}
