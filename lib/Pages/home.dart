import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_coursework_fitness_club/components/DrawerBody/UserPage/teachersRaitingPage.dart';

import '../components/DrawerBody/ShopPage/shopPage.dart';
import '../components/DrawerBody/UserPage/mainBody.dart';
import '../components/DrawerBody/UserPage/mySchedulesBody.dart';
import '../components/DrawerBody/UserPage/shedulesBody.dart';
import '../components/drawer/custom_drawer.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  var listAppBarTitle = {
    "Главная",
    "Расписание занятий",
    "Мои занятия",
    "Тренера",
    "Магазин - товары",
    "Магазин - корзина",
    "Магазин - история"
  };
  int indexPage = 0;
  int indexTitle = 0;
  void _setState(int indexPage, int indexTitle) {
    setState(() {
      this.indexPage = indexPage;
      this.indexTitle = indexTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    var listBodys = {
      MainBody(callback: _setState),
      ShedulesPage(),
      MySchedulesBody(),
      TeacherRaitingPage(),
      ShopPage(callback: _setState)
    };
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 28, 55, 92),
            title: Text(listAppBarTitle.elementAt(indexTitle))),
        drawer: CustomDrawer(callback: _setState),
        body: listBodys.elementAt(indexPage));
  }
}
