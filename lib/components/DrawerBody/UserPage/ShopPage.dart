import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_coursework_fitness_club/Models/ShopClasses.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../HTTP_Connections/http_model.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Item>? listItem;
  bool isLoading = false;
  @override
  void initState() {
    //asyncInitState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethodGet();
    });
    super.initState();
  }

  _asyncMethodGet() async {
    setState(() {
      isLoading = true;
      index = 1;
    });
    listItem = await ApiService().GetAllItem() as List<Item>;
    setState(() {
      isLoading = false;
      index = 0;
    });
  }

  late final List<Widget> listPage = [
    ItemPage(),
    BasketPage(),
    HistoryPage(),
  ];

  final PageController controller = PageController();
  int index = 2;
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          backgroundColor: Color.fromARGB(255, 28, 28, 28),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 3),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(25),
                topLeft: Radius.circular(25),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
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
                      style:
                          TextStyle(fontSize: 15, fontFamily: 'MontserratBold'),
                    ),
                  ),
                  SalomonBottomBarItem(
                    icon: Icon(Icons.shopping_cart_checkout_outlined, size: 25),
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
          body: listPage.elementAt(index)),
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

  Widget ItemPage() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return GridView.builder(
        physics: BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 350),
          itemCount: listItem?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side:
                      const BorderSide(color: Color.fromARGB(255, 33, 33, 33))),
              color: Color.fromARGB(255, 48, 48, 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(100),
                        child: Image.network('${listItem![index].image_URL}',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                      child: Text(
                        "${listItem![index].shopItemName!.length > 12 ? "${listItem![index].shopItemName!.substring(0, 12)}..." : "${listItem![index].shopItemName}"}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'MontserratBold',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.075,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                      child: Text(
                        "${listItem![index].description!.length > 42 ? "${listItem![index].description!.substring(0, 42)}..." : "${listItem![index].description}"}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: const SizedBox(
                      width: 180,
                      child: Divider(
                        color: Color.fromARGB(255, 56, 124, 220),
                        thickness: 2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                    child: Row(children: [
                      Text(
                        "${listItem![index].price}₽",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'MontserratBold',
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            "●",
                            style: TextStyle(
                                color: listItem![index].itemCount! > 0
                                    ? Color.fromARGB(255, 142, 255, 185)
                                    : Color.fromARGB(255, 255, 67, 67)),
                          )),
                      Padding(
                        padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                        child: Text(
                          "${listItem![index].itemCount}шт. в нал.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'MontserratLight',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            );
          });
    });
  }

  Widget BasketPage() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return Center();
    });
  }

  Widget HistoryPage() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter mystate) {
      return Center();
    });
  }
}
