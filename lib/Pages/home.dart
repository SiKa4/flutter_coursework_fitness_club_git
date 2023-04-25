import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_coursework_fitness_club/components/DrawerBody/shedulesBody.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../components/DrawerBody/mySchedulesBody.dart';
import '../components/drawer/custom_drawer.dart';
import '../components/DrawerBody/mainBody.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  var listBodys = {MainBody(), ShedulesPage(), MySchedulesBody()};
  var listAppBarTitle = {"Главная", "Расписание занятий", "Мои занятия"};
  int index = 0;
  void _setState(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 28, 28),
        appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 28, 55, 92),
            title: Text(listAppBarTitle.elementAt(index))),
        drawer: CustomDrawer(callback: _setState),
        body: listBodys.elementAt(index));
  }
}
