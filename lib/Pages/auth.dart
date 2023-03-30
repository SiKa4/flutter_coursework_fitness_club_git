import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Animation/anim.dart';
import '../HTTP_Connections/http_model.dart';
import '../Models/UsersLogins.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  // regular expression to check if string
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;
  bool validatePassword(String pass) {
    if (pass.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (pass.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (pass.length < 8) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(pass)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  void ShowBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.black45,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.73,
          child: Center(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.73,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 28, 28, 28),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    const Text(
                      "Зарегестрирйте аккаунт используя \nлогин и пароль",
                      textAlign: TextAlign.center,
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
                        child: TextField(
                          controller: loginReg,
                          decoration: const InputDecoration(
                              label: Text("Логин",
                                  style: TextStyle(
                                      color: Colors.white30, fontSize: 20)),
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.account_circle_rounded,
                                  color: Colors.white, size: 40)),
                          style: const TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontFamily: 'MontserratLight'),
                          cursorColor: Colors.white10,
                        )),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 54, 54, 54),
                                borderRadius: BorderRadius.circular(20)),
                            child: TextField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: passwordReg,
                              onChanged: (value) {
                                validatePassword(passwordReg.text);
                              },
                              // ignore: prefer_const_constructors
                              decoration: InputDecoration(
                                  label: const Text(
                                    "Пароль",
                                    style: TextStyle(
                                        color: Colors.white30, fontSize: 20),
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  border: InputBorder.none,
                                  // ignore: prefer_const_constructors
                                  prefixIcon: Icon(Icons.password,
                                      color: Colors.white, size: 40)),
                              style: const TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontFamily: 'MontserratLight'),
                              cursorColor: Colors.white10,
                            )),
                        Container(
                         height: MediaQuery.of(context).size.height * 0.004,
                         width: MediaQuery.of(context).size.width * 0.75,
                          child: LinearProgressIndicator(
                            value: password_strength,
                            backgroundColor: Colors.grey[300],
                            minHeight: 5,
                            color: password_strength <= 1 / 4
                                ? Colors.red
                                : password_strength == 2 / 4
                                    ? Colors.yellow
                                    : password_strength == 3 / 4
                                        ? Colors.blue
                                        : Colors.green,
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 54, 54, 54),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: password2Reg,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                              label: const Text(
                                "Повторите пароль",
                                style: TextStyle(
                                    color: Colors.white30, fontSize: 20),
                              ),
                              hintStyle: const TextStyle(color: Colors.white),
                              border: InputBorder.none,
                              // ignore: prefer_const_constructors
                              prefixIcon: Icon(Icons.password,
                                  color: Colors.white, size: 40)),
                          style: const TextStyle(
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
                        // ignore: sort_child_properties_last
                        child: const Text(
                          'Зарегистрироваться',
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
                        onPressed: () {
                          if (passwordReg.text == password2Reg.text &&
                              passwordReg.text.length > 5) {}
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  TextEditingController loginAuth = TextEditingController();
  TextEditingController passwordAuth = TextEditingController();
  TextEditingController loginReg = TextEditingController();
  TextEditingController passwordReg = TextEditingController();
  TextEditingController password2Reg = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 55, 92),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                DropShadow(
                  blurRadius: 12,
                  borderRadius: 20,
                  child: Image.asset(
                    "assets/images/logofitnes.png",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.726,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 28, 28, 28),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      const Text(
                        "Фитнес-клуб - 'GLY UP'",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'MontserratBold',
                          color: Color.fromARGB(255, 149, 178, 218),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.007),
                      const Text(
                        "Войдите в свой аккаунт",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'MontserratLight',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 43, 82, 136),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 54, 54, 54),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            controller: loginAuth,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                label: const Text("Логин",
                                    style: TextStyle(
                                        color: Colors.white30, fontSize: 20)),
                                hintStyle: const TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                // ignore: prefer_const_constructors
                                prefixIcon: Icon(Icons.account_circle_rounded,
                                    color: Colors.white, size: 40)),
                            style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontFamily: 'MontserratLight'),
                            cursorColor: Colors.white10,
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 54, 54, 54),
                              borderRadius: BorderRadius.circular(20)),
                          child: TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: passwordAuth,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                label: const Text(
                                  "Пароль",
                                  style: TextStyle(
                                      color: Colors.white30, fontSize: 20),
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none,
                                // ignore: prefer_const_constructors
                                prefixIcon: Icon(Icons.password,
                                    color: Colors.white, size: 40)),
                            style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontFamily: 'MontserratLight'),
                            cursorColor: Colors.white10,
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: OutlinedButton(
                          // ignore: sort_child_properties_last
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
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            var userFuture = ApiService().getUserByLogPass(
                                loginAuth.text, passwordAuth.text);
                            Users? user = await userFuture;
                            // ignore: use_build_context_synchronously
                            if (user != null) {
                              ApiService.user = user;
                              Navigator.popAndPushNamed(context, "/home");
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Пользователь не найден."),
                              ));
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        // ignore: prefer_const_constructors
                        child: Divider(
                          thickness: 1,
                          color: const Color.fromARGB(255, 43, 82, 136),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: OutlinedButton(
                          // ignore: sort_child_properties_last
                          child: const Text(
                            'Регистрация',
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onPressed: () {
                            ShowBottomSheet();
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      Image(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.width * 0.1,
                          image: NetworkImage(
                              "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png")),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
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
            isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black45,
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.blue,
                      size: 50,
                    ))
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
