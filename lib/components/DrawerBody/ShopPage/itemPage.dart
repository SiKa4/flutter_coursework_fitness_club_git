import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../HTTP_Connections/http_model.dart';
import '../../../Models/ScheduleСlassesUsers.dart';
import '../../../Models/ShopClasses.dart';
import '../UserPage/homeImageView.dart';

class ItemPage extends StatefulWidget {
  final void Function(bool) callback;
  final ValueGetter<List<BasketFullInfo>?> getListBasket;
  final ValueSetter<BasketFullInfo> setListBasketItem;
  final void Function(String) showToast;
  const ItemPage(
      {super.key,
      required this.callback,
      required this.getListBasket,
      required this.setListBasketItem,
      required this.showToast});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List<Item>? listItem;

  bool? isDispose = false;
  @override
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
    widget.callback(true);
    listItem = await ApiService().GetAllItem() as List<Item>;
    widget.callback(false);
    if (!isDispose!) {
      setState(() {});
    }
  }

  PageController _controller = PageController();

  void ShowBottomSheet(Item item, BasketFullInfo? basket) {
    int cntItem = basket == null ? 1 : basket.shopItemCount ?? 1;
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
                            fontSize:
                                20 * MediaQuery.of(context).textScaleFactor,
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
                                    fontSize: 15 *
                                        MediaQuery.of(context).textScaleFactor,
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
                        color: basket == null
                            ? Color.fromARGB(255, 56, 124, 220)
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
                                    fontSize: 17 *
                                        MediaQuery.of(context).textScaleFactor,
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
                                    fontSize: 11.5 *
                                        MediaQuery.of(context).textScaleFactor,
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
                                size:
                                    33 * MediaQuery.of(context).textScaleFactor,
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
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
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
                                    fontSize: 10.2 *
                                        MediaQuery.of(context).textScaleFactor,
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
                              size: 33 * MediaQuery.of(context).textScaleFactor,
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
                                "${basket == null ? "Добавить" : "Изменить"}",
                                style: TextStyle(
                                  fontSize: 10.5 *
                                      MediaQuery.of(context).textScaleFactor,
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
                              onPressed: () async {
                                BasketFullInfo? answer = await ApiService()
                                    .PostBasket(ApiService.user.id_User,
                                        item.id_ShopItem, cntItem);
                                Navigator.pop(context);
                                if (answer != null) {
                                  widget.setListBasketItem(answer);
                                  widget
                                      .showToast("Успешно, корзина обновлена!");
                                } else {
                                  widget.showToast("Ошибка!!!");
                                }
                              },
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: GridView.builder(
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
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  ShowBottomSheet(
                      listItem![index],
                      (widget.getListBasket
                              .call()!
                              .where((x) =>
                                  x.item_id == listItem![index].id_ShopItem)
                              .isNotEmpty
                          ? widget.getListBasket
                              .call()!
                              .where((x) =>
                                  x.item_id == listItem![index].id_ShopItem)
                              .first
                          : null));
                },
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
                      height: MediaQuery.of(context).size.height * 0.036,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                        child: Text(
                          "${listItem![index].shopItemName!.length > 12 ? "${listItem![index].shopItemName!.substring(0, 12)}..." : "${listItem![index].shopItemName}"}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize:
                                16 * MediaQuery.of(context).textScaleFactor,
                            fontFamily: 'MontserratBold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.075,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 3, 5, 0),
                        child: Text(
                          "${listItem![index].description!.length > 42 ? "${listItem![index].description!.substring(0, 42)}..." : "${listItem![index].description}"}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize:
                                13 * MediaQuery.of(context).textScaleFactor,
                            fontFamily: 'MontserratLight',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: Divider(
                          color: Color.fromARGB(255, 56, 124, 220),
                          thickness: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 1, 0, 0),
                      child: Row(children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.27,
                          child: Text(
                            "${listItem![index].price}₽",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize:
                                  14 * MediaQuery.of(context).textScaleFactor,
                              fontFamily: 'MontserratBold',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(1, 0, 0, 0),
                            child: Text(
                              "●",
                              style: TextStyle(
                                  color: listItem![index].itemCount! < 10 &&
                                          listItem![index].itemCount! > 0
                                      ? Color.fromARGB(255, 255, 200, 2)
                                      : listItem![index].itemCount! == 0
                                          ? Color.fromARGB(255, 255, 67, 67)
                                          : Color.fromARGB(255, 142, 255, 185)),
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                          child: Text(
                            "${listItem![index].itemCount}шт.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize:
                                  12 * MediaQuery.of(context).textScaleFactor,
                              fontFamily: 'MontserratLight',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
