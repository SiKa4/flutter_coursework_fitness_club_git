import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 55, 92),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            DropShadow(
              child: Image.asset(
                "assets/images/logofitnes.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7154,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 28, 28, 28),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  const Text(
                    "Фитнес-клуб - 'GLY UP'",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'MontserratBold',
                      color: Color.fromARGB(255, 149, 178, 218),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.007),
                  const Text(
                    "Войдите в свой аккаунт",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'MontserratLight',
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 43, 82, 136),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 54, 54, 54),
                          borderRadius: BorderRadius.circular(20)),
                      child: const TextField(
                        decoration: InputDecoration(
                            label: Text("Логин",
                                style: TextStyle(
                                    color: Colors.white30, fontSize: 20)),
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.account_circle_rounded,
                                color: Colors.white, size: 40)),
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontFamily: 'MontserratLight'),
                        cursorColor: Colors.white10,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 54, 54, 54),
                          borderRadius: BorderRadius.circular(20)),
                      child: const TextField(
                        decoration: InputDecoration(
                            label: Text(
                              "Пароль",
                              style: TextStyle(
                                  color: Colors.white30, fontSize: 20),
                            ),
                            hintStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.password,
                                color: Colors.white, size: 40)),
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontFamily: 'MontserratLight'),
                        cursorColor: Colors.white10,
                      )),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: OutlinedButton(
                      child: const Text(
                        'Войти',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 149, 178, 218),
                            fontFamily: 'MontserratBold'),
                      ),
                      style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromARGB(255, 28, 55, 92),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Divider(
                      thickness: 1,
                      color: const Color.fromARGB(255, 43, 82, 136),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: OutlinedButton(
                      child: const Text(
                        'Зарегестрироваться',
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 149, 178, 218),
                            fontFamily: 'MontserratBold',),
                      ),
                      style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Color.fromARGB(255, 28, 55, 92),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Image(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.1,
                      image: NetworkImage(
                          "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png")),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const InkWell(
                    child: Text(
                      "Забыли пароль? Восстановить.",
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'MontserratBold',
                        color: Color.fromARGB(255, 149, 178, 218),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
