import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_coursework_fitness_club/Models/ShopClasses.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sizing/sizing.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../HTTP_Connections/http_model.dart';
import '../UserPage/homeImageView.dart';
import 'basketPage.dart';
import 'historyPage.dart';
import 'itemPage.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key, required this.callback});
  final void Function(int, int) callback;

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  bool isLoading = false;
  bool isDispose = false;
  List<BasketFullInfo>? listBasket;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethodGet();
    });
    super.initState();
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }

  void _asyncMethodGet() async {
    listBasket =
        await ApiService().GetAllBasketFullInfoByIdUser(ApiService.user.id_User)
                as List<BasketFullInfo>? ??
            <BasketFullInfo>[];
  }

  List<BasketFullInfo>? GetListBasket() {
    return listBasket;
  }

  void ShowToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
  }

  void SetListBasketItem(BasketFullInfo? basket) {
    bool? isEmpty = listBasket
        ?.where((x) => x.id_ShopBasket == basket!.id_ShopBasket)
        .isEmpty;
    if (!isEmpty!) {
      var index = listBasket?.indexOf(listBasket
          ?.where((x) => x.id_ShopBasket == basket!.id_ShopBasket)
          .first as BasketFullInfo);
      listBasket![index!] = basket!;
    } else {
      listBasket!.add(basket!);
    }
  }

  void _setState(bool _isLoading) {
    if (!isDispose) {
      setState(() {
        isLoading = _isLoading;
      });
    }
  }

  void ShowBottomSheet(Item item, BasketFullInfo? basket) {
    int cntItem = basket == null ? 1 : basket.shopItemCount ?? 1;

    PageController _controller = PageController();
    showModalBottomSheet<void>(
        context: context,
        barrierColor: Colors.black45,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) {
            return FractionallySizedBox(
              heightFactor: 0.816,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.94,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 48, 48),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Text(
                          "${item.shopItemName}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24.fss,
                            fontFamily: 'MontserratBold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Divider(
                        color: Color.fromARGB(255, 56, 124, 220),
                        thickness: 2,
                      ),
                    ),
                    Stack(alignment: Alignment.bottomCenter, children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        child: PageView(
                          controller: _controller,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            itemImageView(
                              "${item.image_URL}",
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: SmoothPageIndicator(
                            controller: _controller,
                            effect: WormEffect(
                                activeDotColor:
                                    Color.fromARGB(255, 58, 111, 185)),
                            count: 5,
                          ),
                        ),
                      )
                    ]),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Divider(
                        color: Color.fromARGB(255, 56, 124, 220),
                        thickness: 2,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Scrollbar(
                            isAlwaysShown: true,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Text(
                                  "${item.description}",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 20.fss,
                                    fontFamily: 'MontserratLight',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Divider(
                        color: item.itemCount! < 10 && item.itemCount! > 0
                            ? Color.fromARGB(255, 255, 200, 2)
                            : item.itemCount! == 0
                                ? Color.fromARGB(255, 255, 67, 67)
                                : Color.fromARGB(255, 142, 255, 185),
                        thickness: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.26,
                                child: Text(
                                  "${item.price}₽",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20.fss,
                                    fontFamily: 'MontserratBold',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Row(children: [
                                Text(
                                  "●",
                                  style: TextStyle(
                                      color: item.itemCount! < 10 &&
                                              item.itemCount! > 0
                                          ? Color.fromARGB(255, 255, 200, 2)
                                          : item.itemCount! == 0
                                              ? Color.fromARGB(255, 255, 67, 67)
                                              : Color.fromARGB(
                                                  255, 142, 255, 185)),
                                ),
                                Text(
                                  "${item.itemCount}шт. в нал.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14.fss,
                                    fontFamily: 'MontserratLight',
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            ]),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Color.fromARGB(255, 28, 55, 92),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Color.fromARGB(255, 149, 178, 218),
                                size: 36.ss,
                              ),
                            ),
                            onTap: () {
                              if (cntItem > 1)
                                mystate(() {
                                  cntItem--;
                                });
                            },
                          ),
                        ),
                        Column(children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            alignment: Alignment.center,
                            child: Text("${cntItem} шт.",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18.fss,
                                  fontFamily: 'MontserratLight',
                                  color: Colors.white,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              alignment: Alignment.center,
                              child: Text(
                                  "${double.parse((cntItem * item.price!).toStringAsFixed(1))}₽",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 13.fss,
                                    fontFamily: 'MontserratBold',
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ]),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color.fromARGB(255, 28, 55, 92),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Color.fromARGB(255, 149, 178, 218),
                              size: 36.ss,
                            ),
                          ),
                          onTap: () {
                            if (cntItem < item.itemCount!)
                              mystate(() {
                                cntItem++;
                              });
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.26,
                            height: MediaQuery.of(context).size.height * 0.05,
                            child: OutlinedButton(
                              // ignore: sort_child_properties_last
                              child: Text(
                                "${item.itemCount == 0 ? "Нет в наличии" : basket == null ? "Добавить" : "Изменить"}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.fss,
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
                              onPressed: item.itemCount != 0
                                  ? () async {
                                      Navigator.pop(context);
                                      BasketFullInfo? answer =
                                          await ApiService().PostBasket(
                                              ApiService.user.id_User,
                                              item.id_ShopItem,
                                              cntItem);
                                      if (answer != null) {
                                        setState(() {
                                          SetListBasketItem(answer);
                                        });
                                        ShowToast(
                                            "Успешно, корзина обновлена!");
                                      } else {
                                        ShowToast("Ошибка!!!");
                                      }
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  final PageController controller = PageController();
  int index = 0;

  Widget build(BuildContext context) {
    final listPage = <StatefulWidget>[
      ItemPage(
          callback: _setState,
          getListBasket: GetListBasket,
          showBottomSheet: ShowBottomSheet),
      BasketPage(getListBasket: GetListBasket, showToast: ShowToast),
      HistoryPage(callback: _setState, getListBasket: GetListBasket)
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
                  onTap: (i) {
                    setState(() {
                      index = i;
                      widget.callback(4, 4 + i);
                    });
                  },
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
                      icon: Icon(Icons.shopping_basket_outlined, size: 25),
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
