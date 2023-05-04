import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_coursework_fitness_club/Models/ShopClasses.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../HTTP_Connections/http_model.dart';
import 'basketPage.dart';
import 'historyPage.dart';
import 'itemPage.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}




class _ShopPageState extends State<ShopPage> {
  @override
  bool isLoading = false;
  bool isDispose = false;
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    isDispose = true;
    super.dispose();
  }

  void _setState(bool _isLoading) {
    if (!isDispose) {
      setState(() {
        isLoading = _isLoading;
      });
    }
  }

  final PageController controller = PageController();
  int index = 0;

  Widget build(BuildContext context) {
    final listPage = <StatefulWidget>[
      ItemPage(callback: _setState),
      BasketPage(callback: _setState),
      HistoryPage(callback: _setState)
    ];

    return Stack(children: [
      Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 3),
            child: Container(
              decoration: new BoxDecoration(
                border: Border.all(
                    width: 1, color: Color.fromARGB(255, 20, 20, 20)),
                borderRadius: new BorderRadius.all(Radius.circular(25.0)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(23)),
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
                        style: TextStyle(
                            fontSize: 15, fontFamily: 'MontserratBold'),
                      ),
                    ),
                    SalomonBottomBarItem(
                      icon:
                          Icon(Icons.shopping_cart_checkout_outlined, size: 25),
                      title: Text("Корзина",
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'MontserratBold')),
                    ),
                    SalomonBottomBarItem(
                      icon: Icon(Icons.history_outlined, size: 25),
                      title: Text("История заказовы",
                          style: TextStyle(
                              fontSize: 13, fontFamily: 'MontserratBold')),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: IndexedStack(index: index, children: listPage)),
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
    ]);
  }
}
