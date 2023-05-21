import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizing/sizing.dart';

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
    RoleNameController.text = ApiService.user.role_Name;
  }

  AlertDialogExit() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0, left: 5, right: 5),
            backgroundColor: Color.fromARGB(224, 61, 73, 91),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                children: [
                  Text(
                    "Вы уверены, что хотите выйти?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.fss,
                        color: Colors.white,
                        fontFamily: 'MontserratBold'),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                    size: 30.ss,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: OutlinedButton(
                        // ignore: sort_child_properties_last
                        child: Text(
                          'Да',
                          style: TextStyle(
                            fontSize: 18.fss,
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
                        onPressed: () async {
                          Navigator.pop(context);
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setInt('UserId', -1);
                          ApiService.user = null;
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (route) => false);
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: OutlinedButton(
                        // ignore: sort_child_properties_last
                        child: Text(
                          'Нет',
                          style: TextStyle(
                            fontSize: 18.fss,
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
                        onPressed: () {Navigator.pop(context);},
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          );
        });
  }

  TextEditingController FullNameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController RoleNameController = TextEditingController();
  TextEditingController NumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isCheck = false;
  RegExp number_valid = new RegExp(
      '^((\\+7|7|8) \\(([0-9]{3})\\) ([0-9]){3}-([0-9]){2}-([0-9]){2})\$');
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
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
                AlertDialogExit();
              },
            )
          ],
        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Column(children: [
                TextField(
                  controller: FullNameController,
                  onChanged: (value) {
                    if (isCheck) {
                      _formKey.currentState!.validate();
                    }
                  },
                  decoration: InputDecoration(
                      enabled: false,
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.97,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 54, 54, 54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      label: Text("ФИО",
                          style: TextStyle(
                              color: Colors.white30, fontSize: 20.fss)),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.account_circle_rounded,
                          color: Colors.white, size: 36.ss)),
                  style: TextStyle(
                      fontSize: 20.fss,
                      color: Colors.white,
                      fontFamily: 'MontserratLight'),
                  cursorColor: Colors.white10,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: EmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.97,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 54, 54, 54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      label: Text("Почта",
                          style: TextStyle(
                              color: Colors.white30, fontSize: 20.fss)),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.alternate_email,
                          color: Colors.white, size: 36.ss)),
                  onChanged: (value) {
                    if (isCheck) {
                      _formKey.currentState!.validate();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста введите почту.';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Пожалуйста введите валидную почту!';
                    }
                    return null;
                  },
                  style: TextStyle(
                      fontSize: 20.fss,
                      color: Colors.white,
                      fontFamily: 'MontserratLight'),
                  cursorColor: Colors.white10,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  inputFormatters: [maskFormatter],
                  controller: NumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста введите номер телефона.';
                    } else if (!number_valid.hasMatch(value)) {
                      return 'Пожалуйста введите телефон полностью!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (isCheck) {
                      _formKey.currentState!.validate();
                    }
                  },
                  decoration: InputDecoration(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.97,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 54, 54, 54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      label: Text("Номер телефона",
                          style: TextStyle(
                              color: Colors.white30, fontSize: 20.fss)),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon:
                          Icon(Icons.call, color: Colors.white, size: 36.ss)),
                  style: TextStyle(
                      fontSize: 20.fss,
                      color: Colors.white,
                      fontFamily: 'MontserratLight'),
                  cursorColor: Colors.white10,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextField(
                  controller: RoleNameController,
                  decoration: InputDecoration(
                      enabled: false,
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.97,
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 54, 54, 54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      label: Text("Роль",
                          style: TextStyle(
                              color: Colors.white30, fontSize: 20.fss)),
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.account_circle_rounded,
                          color: Colors.white, size: 36.ss)),
                  style: TextStyle(
                      fontSize: 20.fss,
                      color: Colors.white,
                      fontFamily: 'MontserratLight'),
                  cursorColor: Colors.white10,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Divider(
                    color: Color.fromARGB(255, 56, 124, 220),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: OutlinedButton(
                    // ignore: sort_child_properties_last
                    child: Text(
                      'Сохранить',
                      style: TextStyle(
                        fontSize: 16.fss,
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
                      isCheck = true;
                      final FormState? formState = _formKey.currentState;
                      formState!.save();
                      if (formState.validate()) {
                        //code save
                      }
                    },
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
}
