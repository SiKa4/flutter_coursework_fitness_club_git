import 'package:drop_shadow/drop_shadow.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizing/sizing.dart';


import '../HTTP_Connections/http_model.dart';
import '../Models/UsersLogins.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailReg = TextEditingController();
  TextEditingController fullNameReg = TextEditingController();
  TextEditingController numberPhoneReg = TextEditingController();
  TextEditingController passwordReg = TextEditingController();
  TextEditingController password2Reg = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isCheck = false;
  bool _isObscure = true;
  bool _isConfirmObscure = true;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  RegExp fullName_valid =
      new RegExp('^[а-яА-ЯёЁa-zA-Z]+ [а-яА-ЯёЁa-zA-Z]+ [а-яА-ЯёЁa-zA-Z]+\$');
  RegExp number_valid = new RegExp(
      '^((\\+7|7|8) \\(([0-9]{3})\\) ([0-9]){3}-([0-9]){2}-([0-9]){2})\$');
  void ShowToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
  }

  bool isCodeEnter = false;
  var listFocuseNode = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  var listTextEditingController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  String? codeString;
  var maskFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  double password_strength = 0;
  void ShowBottomSheet() {
    dispose() {
      emailReg.text = "";
      passwordReg.text = "";
      password2Reg.text = "";
      listTextEditingController.forEach((element) {
        element.text = "";
      });
      isCodeEnter = false;
    }

    showModalBottomSheet<void>(
        context: context,
        barrierColor: Colors.black45,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter mystate) {
              bool validatePassword(String pass) {
                if (pass.isEmpty) {
                  mystate(() {
                    password_strength = 0;
                  });
                } else if (pass.length < 6) {
                  mystate(() {
                    password_strength = 1 / 4;
                  });
                } else if (pass.length < 8) {
                  mystate(() {
                    password_strength = 2 / 4;
                  });
                } else {
                  if (pass_valid.hasMatch(pass)) {
                    mystate(() {
                      password_strength = 4 / 4;
                    });
                    return true;
                  } else {
                    mystate(() {
                      password_strength = 3 / 4;
                    });
                    return false;
                  }
                }
                return false;
              }

              Future<int> GetNextIndexEmptyController() async {
                if (!listTextEditingController
                    .where((element) => element.text == "")
                    .isEmpty) {
                  int index = listTextEditingController.indexOf(
                      listTextEditingController
                          .where((element) => element.text == "")
                          .first);
                  return index;
                } else {
                  if (codeString != null &&
                      codeString ==
                          "${listTextEditingController[0].text}${listTextEditingController[1].text}${listTextEditingController[2].text}${listTextEditingController[3].text}${listTextEditingController[4].text}") {
                    var answer = ApiService().setNewUserByLoginAndPassword(
                        emailReg.text,
                        passwordReg.text,
                        fullNameReg.text,
                        numberPhoneReg.text);
                    bool? isOk = await answer;
                    if (isOk) {
                      ShowToast("Пользователь успешно зарегестрирован!");
                    } else {
                      ShowToast("Ошибка!");
                    }
                    dispose();
                    Navigator.pop(context);
                  } else {
                    listTextEditingController.forEach((element) {
                      element.text = "";
                    });
                  }
                  return 0;
                }
              }

              return FractionallySizedBox(
                heightFactor: 0.73,
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.73,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 28, 28, 28),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60))),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 32.0),
                              child: !isCodeEnter
                                  ? Column(children: [
                                      Text(
                                        "Зарегистрируйте аккаунт используя \nпочту и пароль",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15.fss,
                                          fontFamily: 'MontserratLight',
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 43, 82, 136),
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      TextFormField(
                                        controller: emailReg,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                            ),
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(255, 54, 54, 54),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            label: Text("Почта",
                                                style: TextStyle(
                                                    color: Colors.white30,
                                                    fontSize: 20.fss)),
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            prefixIcon: Icon(
                                                Icons.alternate_email,
                                                color: Colors.white,
                                                size: 36.ss)),
                                        onChanged: (value) {
                                          if (isCheck) {
                                            _formKey.currentState!.validate();
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Пожалуйста введите почту.';
                                          } else if (!EmailValidator.validate(
                                              value)) {
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
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      TextFormField(
                                        controller: fullNameReg,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Пожалуйста введите ФИО.';
                                          } else if (!fullName_valid
                                              .hasMatch(value)) {
                                            return 'Пожалуйста введите полное ФИО!';
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
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                            ),
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(255, 54, 54, 54),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            label: Text("ФИО",
                                                style: TextStyle(
                                                    color: Colors.white30,
                                                    fontSize: 20.fss)),
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            prefixIcon: Icon(
                                                Icons.account_circle_rounded,
                                                color: Colors.white,
                                                size: 36.ss)),
                                        style: TextStyle(
                                            fontSize: 20.fss,
                                            color: Colors.white,
                                            fontFamily: 'MontserratLight'),
                                        cursorColor: Colors.white10,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      TextFormField(
                                        inputFormatters: [maskFormatter],
                                        controller: numberPhoneReg,
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Пожалуйста введите номер телефона.';
                                          } else if (!number_valid
                                              .hasMatch(value)) {
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
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                            ),
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(255, 54, 54, 54),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            label: Text("Номер телефона",
                                                style: TextStyle(
                                                    color: Colors.white30,
                                                    fontSize: 20.fss)),
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            prefixIcon: Icon(Icons.call,
                                                color: Colors.white, size: 36.ss)),
                                        style: TextStyle(
                                            fontSize: 20.fss,
                                            color: Colors.white,
                                            fontFamily: 'MontserratLight'),
                                        cursorColor: Colors.white10,
                                      ),

                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      TextFormField(
                                        obscureText: _isObscure,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        controller: passwordReg,
                                        onChanged: (value) {
                                          if (isCheck) {
                                            _formKey.currentState!.validate();
                                          }
                                          validatePassword(passwordReg.text);
                                        },
                                        validator: (value) {
                                          if (password_strength < 3 / 4) {
                                            return "Придумайте более надежный пароль!";
                                          }
                                          return null;
                                        },

                                        // ignore: prefer_const_constructors
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                            ),
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(255, 54, 54, 54),
                                            label: Text(
                                              "Пароль",
                                              style: TextStyle(
                                                color: Colors.white30,
                                                fontSize: 20.fss,
                                              ),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                  !_isObscure
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.white),
                                              onPressed: () {
                                                mystate(() {
                                                  _isObscure = !_isObscure;
                                                });
                                              },
                                            ),
                                            hintStyle:
                                                TextStyle(color: Colors.white),
                                            // ignore: prefer_const_constructors
                                            prefixIcon: Icon(Icons.password,
                                                color: Colors.white, size: 36.ss)),

                                        style: TextStyle(
                                            fontSize: 20.fss,
                                            color: Colors.white,
                                            fontFamily: 'MontserratLight'),
                                        cursorColor: Colors.white10,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.004,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
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
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      TextFormField(
                                        obscureText: _isConfirmObscure,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        controller: password2Reg,
                                        // ignore: prefer_const_constructors
                                        decoration: InputDecoration(
                                            constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                            ),
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(255, 54, 54, 54),
                                            label: Text(
                                              "Повторите пароль",
                                              style: TextStyle(
                                                  color: Colors.white30,
                                                  fontSize: 20.fss),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide: BorderSide.none,
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              borderSide:
                                                  BorderSide(color: Colors.red),
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                !_isConfirmObscure
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                mystate(() {
                                                  _isConfirmObscure =
                                                      !_isConfirmObscure;
                                                });
                                              },
                                            ),
                                            hintStyle: const TextStyle(
                                                color: Colors.white),
                                            // ignore: prefer_const_constructors
                                            prefixIcon: Icon(Icons.password,
                                                color: Colors.white, size: 36.ss)),
                                        validator: (value) {
                                          if (passwordReg.text !=
                                                  password2Reg.text ||
                                              password2Reg.text == "") {
                                            return "Пароли не совпадают!";
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          if (isCheck) {
                                            _formKey.currentState!.validate();
                                          }
                                        },
                                        style: TextStyle(
                                            fontSize: 20.fss,
                                            color: Colors.white,
                                            fontFamily: 'MontserratLight'),

                                        cursorColor: Colors.white10,
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: OutlinedButton(
                                          // ignore: sort_child_properties_last
                                          child: const Text(
                                            'Зарегистрироваться',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 149, 178, 218),
                                                fontFamily: 'MontserratBold'),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                              primary: Colors.white,
                                              backgroundColor: Color.fromARGB(
                                                  255, 28, 55, 92),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)))),
                                          onPressed: () async {
                                            isCheck = true;
                                            final FormState? formState =
                                                _formKey.currentState;
                                            formState!.save();
                                            if (formState.validate()) {
                                              var Enabled = ApiService()
                                                  .isExistsUserByLog(
                                                      emailReg.text);
                                              bool? isEnabled = await Enabled;
                                              if (!isEnabled) {
                                                codeString = await ApiService()
                                                    .getSendCodeEmailAdress(
                                                        emailReg.text);
                                                FocusScope.of(context)
                                                    .unfocus();
                                                mystate(() {
                                                  isCodeEnter = true;
                                                });
                                                listFocuseNode[0]
                                                    .requestFocus();
                                              } else {
                                                ShowToast(
                                                    "Ошибка!\n Такая почта уже зарегистрирована!");
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      // ignore: dead_code
                                    ])
                                  : Column(
                                      children: [
                                        Text(
                                          "Подтвердите почту",
                                          style: TextStyle(
                                            fontSize: 22.fss,
                                            fontFamily: 'MontserratBold',
                                            color: Color.fromARGB(
                                                255, 149, 178, 218),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        Text(
                                          "Код был отправлен вам на почтовый адрес",
                                          style: TextStyle(
                                            fontSize: 15.fss,
                                            fontFamily: 'MontserratLight',
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 43, 82, 136),
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              child: TextFormField(
                                                focusNode: listFocuseNode[0],
                                                controller:
                                                    listTextEditingController[
                                                        0],
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 1,
                                                cursorHeight: 0,
                                                cursorWidth: 0,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                onChanged: (value) async {
                                                  listFocuseNode[
                                                          await GetNextIndexEmptyController()]
                                                      .requestFocus();
                                                },
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  filled: true,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  fillColor: Color.fromARGB(
                                                      255, 28, 55, 92),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                18)),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 38, 122, 240),
                                                    fontSize: 40.fss),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              child: TextFormField(
                                                focusNode: listFocuseNode[1],
                                                controller:
                                                    listTextEditingController[
                                                        1],
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 1,
                                                cursorHeight: 0,
                                                cursorWidth: 0,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                onChanged: (value) async {
                                                  listFocuseNode[
                                                          await GetNextIndexEmptyController()]
                                                      .requestFocus();
                                                },
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  filled: true,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  fillColor: Color.fromARGB(
                                                      255, 28, 55, 92),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                18)),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 38, 122, 240),
                                                    fontSize: 40.fss),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              child: TextFormField(
                                                focusNode: listFocuseNode[2],
                                                controller:
                                                    listTextEditingController[
                                                        2],
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 1,
                                                cursorHeight: 0,
                                                cursorWidth: 0,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                onChanged: (value) async {
                                                  listFocuseNode[
                                                          await GetNextIndexEmptyController()]
                                                      .requestFocus();
                                                },
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  filled: true,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  fillColor: Color.fromARGB(
                                                      255, 28, 55, 92),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                18)),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 38, 122, 240),
                                                    fontSize: 40.fss),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              child: TextFormField(
                                                focusNode: listFocuseNode[3],
                                                controller:
                                                    listTextEditingController[
                                                        3],
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 1,
                                                cursorHeight: 0,
                                                cursorWidth: 0,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                onChanged: (value) async {
                                                  listFocuseNode[
                                                          await GetNextIndexEmptyController()]
                                                      .requestFocus();
                                                },
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  filled: true,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  fillColor: Color.fromARGB(
                                                      255, 28, 55, 92),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                18)),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 38, 122, 240),
                                                    fontSize: 40.fss),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              child: TextFormField(
                                                focusNode: listFocuseNode[4],
                                                controller:
                                                    listTextEditingController[
                                                        4],
                                                keyboardType:
                                                    TextInputType.number,
                                                maxLength: 1,
                                                cursorHeight: 0,
                                                cursorWidth: 0,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                onChanged: (value) async {
                                                  listFocuseNode[
                                                          await GetNextIndexEmptyController()]
                                                      .requestFocus();
                                                },
                                                decoration: InputDecoration(
                                                  counterText: '',
                                                  filled: true,
                                                  disabledBorder:
                                                      InputBorder.none,
                                                  fillColor: Color.fromARGB(
                                                      255, 28, 55, 92),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                18)),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 38, 122, 240),
                                                    fontSize: 40.fss),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                            ),
                          )),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  TextEditingController loginAuth = TextEditingController();
  TextEditingController passwordAuth = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 55, 92),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 32.0),
                      child: Column(
                        children: [
                          Text(
                            "Фитнес-клуб - 'GLY UP'",
                            style: TextStyle(
                              fontSize: 22.fss,
                              fontFamily: 'MontserratBold',
                              color: Color.fromARGB(255, 149, 178, 218),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.007),
                          Text(
                            "Войдите в свой аккаунт",
                            style: TextStyle(
                              fontSize: 15.fss,
                              fontFamily: 'MontserratLight',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 43, 82, 136),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          TextField(
                            controller: loginAuth,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 54, 54, 54),
                                label: const Text("Почта",
                                    style: TextStyle(
                                        color: Colors.white30, fontSize: 20)),
                                hintStyle: const TextStyle(color: Colors.white),
                                // ignore: prefer_const_constructors
                                prefixIcon: Icon(Icons.alternate_email,
                                    color: Colors.white, size: 36.ss)),
                            style: TextStyle(
                                fontSize: 20.fss,
                                color: Colors.white,
                                fontFamily: 'MontserratLight'),
                            cursorColor: Colors.white10,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: passwordAuth,
                            // ignore: prefer_const_constructors
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  borderSide: BorderSide.none,
                                ),
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 54, 54, 54),
                                label: Text(
                                  "Пароль",
                                  style: TextStyle(
                                      color: Colors.white30, fontSize: 20.fss),
                                ),
                                hintStyle: TextStyle(color: Colors.white),
                                // ignore: prefer_const_constructors
                                prefixIcon: Icon(Icons.password,
                                    color: Colors.white, size: 36.ss)),
                            style: TextStyle(
                                fontSize: 20.fss,
                                color: Colors.white,
                                fontFamily: 'MontserratLight'),
                            cursorColor: Colors.white10,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: OutlinedButton(
                              // ignore: sort_child_properties_last
                              child: Text(
                                'Войти',
                                style: TextStyle(
                                    fontSize: 19.fss,
                                    color: Color.fromARGB(255, 149, 178, 218),
                                    fontFamily: 'MontserratBold'),
                              ),
                              style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor:
                                      Color.fromARGB(255, 28, 55, 92),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  isLoading = true;
                                });
                                var userFuture = ApiService().getUserByLogPass(
                                    loginAuth.text, passwordAuth.text);
                                Users? user = await userFuture;
                                // ignore: use_build_context_synchronously
                                if (user != null) {
                                  ApiService.user = user;
                                  ApiService.login = await ApiService()
                                      .getLoginsByIdUser(user.id_User ?? -1);
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setInt(
                                      'UserId', user.id_User ?? -1);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, "/home", (route) => false);
                                } else {
                                  ShowToast("Пользователь не найден.");
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            // ignore: prefer_const_constructors
                            child: Divider(
                              thickness: 1.3,
                              color: const Color.fromARGB(255, 43, 82, 136),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.01),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: OutlinedButton(
                              // ignore: sort_child_properties_last
                              child: Text(
                                'Регистрация',
                                style: TextStyle(
                                  fontSize: 19.fss,
                                  color: Color.fromARGB(255, 149, 178, 218),
                                  fontFamily: 'MontserratBold',
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor:
                                      Color.fromARGB(255, 28, 55, 92),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                              onPressed: () {
                                ShowBottomSheet();
                              },
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          Image(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.1,
                              image: NetworkImage(
                                  "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png")),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          InkWell(
                            child: Text(
                              "Забыли пароль? Восстановить.",
                              style: TextStyle(
                                fontSize: 13.fss,
                                fontFamily: 'MontserratBold',
                                color: Color.fromARGB(255, 149, 178, 218),
                              ),
                            ),
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
