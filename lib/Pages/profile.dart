import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../HTTP_Connections/http_model.dart';
import '../Models/UsersLogins.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    super.initState();
    FullNameController.text = ApiService.user.fullName;
    NumberController.text = ApiService.user.number;
    EmailController.text = ApiService.login.login;
    FullNameController.text = ApiService.user.fullName;
  }

  TextEditingController FullNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController RoleNameController = TextEditingController();
  TextEditingController NumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        appBar: AppBar(
          title: Text('Мой профиль'),
          backgroundColor: Color.fromARGB(255, 28, 55, 92),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setInt('UserId', -1);
                // ignore: use_build_context_synchronously
                Navigator.popAndPushNamed(context, "/");
                FocusScope.of(context).unfocus();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Column(children: [
            TextField(
              controller: FullNameController,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  label: const Text("Полное имя",
                      style: TextStyle(color: Colors.white30, fontSize: 20)),
                  hintStyle: const TextStyle(color: Colors.white),
                  // ignore: prefer_const_constructors
                  prefixIcon: Icon(Icons.account_circle_rounded,
                      color: Colors.white, size: 40)),
              style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontFamily: 'MontserratLight'),
              cursorColor: Colors.white10,
            ),
            TextField(
              controller: EmailController,
              enabled: false,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  label: const Text("Почта",
                      style: TextStyle(color: Colors.white30, fontSize: 20)),
                  hintStyle: const TextStyle(color: Colors.white),
                  // ignore: prefer_const_constructors
                  prefixIcon: Icon(Icons.account_circle_rounded,
                      color: Colors.white, size: 40)),
              style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontFamily: 'MontserratLight'),
              cursorColor: Colors.white10,
            ),
            TextField(
              controller: NumberController,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  label: const Text("Номер телефона",
                      style: TextStyle(color: Colors.white30, fontSize: 20)),
                  hintStyle: const TextStyle(color: Colors.white),
                  // ignore: prefer_const_constructors
                  prefixIcon: Icon(Icons.account_circle_rounded,
                      color: Colors.white, size: 40)),
              style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontFamily: 'MontserratLight'),
              cursorColor: Colors.white10,
            ),
            TextField(
              controller: RoleNameController,
              enabled: false,
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  label: const Text("Тип учетной записи",
                      style: TextStyle(color: Colors.white30, fontSize: 20)),
                  hintStyle: const TextStyle(color: Colors.white),
                  // ignore: prefer_const_constructors
                  prefixIcon: Icon(Icons.account_circle_rounded,
                      color: Colors.white, size: 40)),
              style: const TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontFamily: 'MontserratLight'),
              cursorColor: Colors.white10,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.75,
              child: OutlinedButton(
                // ignore: sort_child_properties_last
                child: const Text(
                  'Сохранить',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 149, 178, 218),
                    fontFamily: 'MontserratBold',
                  ),
                ),
                style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Color.fromARGB(255, 28, 55, 92),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                onPressed: () {},
              ),
            ),
          ]),
        ));
  }
}
