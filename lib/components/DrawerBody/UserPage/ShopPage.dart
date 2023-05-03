import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_coursework_fitness_club/Models/ShopClasses.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../HTTP_Connections/http_model.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Item>? listItem;
  @override
  void initState() {
    //asyncInitState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethodGet();
    });
  }

  _asyncMethodGet() async {
    listItem = await ApiService().GetAllItem() as List<Item>;
  }

  var listPage = {
    ItemPage(),
    BasketPage(),
    HistoryPage(),
  };

  final PageController controller = PageController();
  int index = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 28, 28),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: SalomonBottomBar(
            backgroundColor: Color.fromARGB(255, 47, 47, 47),
            currentIndex: index,
            onTap: (i) => setState(() => index = i),
            unselectedItemColor: Colors.white60,
            selectedItemColor: Color.fromARGB(255, 92, 140, 207),
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.apps_outlined, size: 25),
                title: Text(
                  "Товары",
                  style: TextStyle(fontSize: 15, fontFamily: 'MontserratBold'),
                ),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.shopping_cart_checkout_outlined, size: 25),
                title: Text("Корзина",
                    style:
                        TextStyle(fontSize: 15, fontFamily: 'MontserratBold')),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.history_outlined, size: 25),
                title: Text("История заказовы",
                    style:
                        TextStyle(fontSize: 13, fontFamily: 'MontserratBold')),
              ),
            ],
          ),
        ),
      ),
      body: listPage.elementAt(index),
    );
  }
}

Widget ItemPage() {
  return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
    return Center();
  });
}

Widget BasketPage() {
  return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
    return Center();
  });
}

Widget HistoryPage() {
  return StatefulBuilder(builder: (BuildContext context, StateSetter mystate) {
    return Center();
  });
}
