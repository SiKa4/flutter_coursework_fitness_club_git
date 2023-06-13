import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';
import '../../../HTTP_Connections/http_model.dart';
import '../../../Models/ShopClasses.dart';

class ItemPage extends StatefulWidget {
  final void Function(bool) callback;
  final ValueGetter<List<BasketFullInfo>?> getListBasket;
  final void Function(Item, BasketFullInfo?) showBottomSheet;
  const ItemPage(
      {super.key,
      required this.callback,
      required this.getListBasket,
      required this.showBottomSheet});

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
    listItem = await ApiService().GetAllItem() as List<Item>;
    if (!isDispose!) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      child: GridView.builder(
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 330.ss),
          itemCount: listItem?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(
                      color: Color.fromARGB(255, 33, 33, 33))),
              color: Color.fromARGB(255, 48, 48, 48),
              child: InkWell(
                borderRadius: BorderRadius.circular(20.0),
                onTap: () {
                  widget.showBottomSheet(
                      listItem![index],
                      (widget.getListBasket
                              .call()!
                              .where((x) =>
                                  x.item_id ==
                                  listItem![index].id_ShopItem)
                              .isNotEmpty
                          ? widget.getListBasket
                              .call()!
                              .where((x) =>
                                  x.item_id ==
                                  listItem![index].id_ShopItem)
                              .first
                          : null));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(100),
                            child: Image.network(
                                '${listItem![index].image_URL}',
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      widget.getListBasket
                              .call()!
                              .where((x) =>
                                  x.item_id ==
                                  listItem![index].id_ShopItem)
                              .isNotEmpty
                          ? Positioned.fill(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height *
                                        0.12,
                                width: MediaQuery.of(context).size.width *
                                    0.977,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(149, 25, 25, 25),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(10, 0, 0, 5),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        child: Icon(
                                          Icons
                                              .shopping_cart_checkout_outlined,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          size: 30.ss,
                                        )),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox.shrink()
                    ]),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.036,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                        child: Text(
                          "${listItem![index].shopItemName!.length > 12 ? "${listItem![index].shopItemName!.substring(0, 12)}..." : "${listItem![index].shopItemName}"}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 19.fss,
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
                            fontSize: 15.fss,
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
                              fontSize: 16.5.fss,
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
                                  color: listItem![index].itemCount! <
                                              10 &&
                                          listItem![index].itemCount! > 0
                                      ? Color.fromARGB(255, 255, 200, 2)
                                      : listItem![index].itemCount! == 0
                                          ? Color.fromARGB(
                                              255, 255, 67, 67)
                                          : Color.fromARGB(
                                              255, 142, 255, 185)),
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
                          child: Text(
                            "${listItem![index].itemCount}шт.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.fss,
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
