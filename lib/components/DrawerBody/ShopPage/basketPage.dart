import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../../../Animation/anim.dart';
import '../../../HTTP_Connections/http_model.dart';
import '../../../Models/ShopClasses.dart';
import 'basketRegistrationPage.dart';

class BasketPage extends StatefulWidget {
  const BasketPage(
      {super.key,
      required this.getListBasket,
      required this.showToast,
      required this.navBarShopPage,
      required this.listShopOrders});
  final ValueGetter<List<BasketFullInfo?>?> getListBasket;
  final void Function(String) showToast;
  final void Function(bool) navBarShopPage;
  final ValueGetter<List<ShopOrderFullInfo>?>? listShopOrders;
  //final void Function(BasketFullInfo) setBasket;
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  void setStatee(int idOrder) {
    for (var i
        in widget.getListBasket.call()!.where((x) => x!.isSelected == true)) {
      setState(() {
        i!.order_id = idOrder;
      });
      setState(() {
        isSelected = false;
        widget.navBarShopPage(true);
        isEnabledNavBar = true;
      });
    }
  }

  void onLongPress(int index) {
    setState(() {
      widget.getListBasket.call()![index]!.isSelected =
          !widget.getListBasket.call()![index]!.isSelected!;
      if (widget.getListBasket
          .call()!
          .where((x) => x?.isSelected == true)
          .isNotEmpty) {
        isSelected = true;
        widget.navBarShopPage(false);
        isEnabledNavBar = false;

        priceSelectedItem = 0;
        cntItem = 0;
        for (var i in widget.getListBasket
            .call()!
            .where((x) => x!.isSelected == true)) {
          priceSelectedItem += i!.shopItemCount! * i.item_Price!;
          cntItem += i.shopItemCount!;
        }
      } else {
        isSelected = false;
        widget.navBarShopPage(true);
        isEnabledNavBar = true;
      }
    });
  }

  bool isSelected = false;
  bool isEnabledNavBar = true;
  double priceSelectedItem = 0;
  int cntItem = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 28, 28, 28),
      bottomNavigationBar: !isEnabledNavBar
          ? Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 3),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: new BoxDecoration(
                    color: Color.fromARGB(255, 28, 55, 92),
                    border: Border.all(
                        width: 1, color: Color.fromARGB(255, 20, 20, 20)),
                    borderRadius: new BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: OutlinedButton(
                    onPressed: () async {
                      Navigator.of(context).push(Animations().createRoute(
                          BasketRegistrationPage(
                              listBasket: widget.getListBasket
                                  .call()!
                                  .where((x) => x!.isSelected == true)
                                  .toList(),
                              setStateBasket: setStatee,
                              listShopOrders: widget.listShopOrders)));
                      // for (var i in widget.getListBasket
                      //     .call()!
                      //     .where((x) => x!.isSelected == true)
                      //     .toList()) {
                      //   i!.isSelected = false;
                      // }
                      // setState(() {
                      //   isSelected = false;
                      //   widget.navBarShopPage(true);
                      //   isEnabledNavBar = false;
                      // });
                    },
                    style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25)))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "К оформлению",
                            style: TextStyle(
                              fontSize: 17.fss,
                              fontFamily: 'MontserratBold',
                              color: const Color.fromARGB(255, 149, 178, 218),
                            ),
                          ),
                          Text(
                            "${cntItem}шт., ${double.parse((priceSelectedItem).toStringAsFixed(2))}₽",
                            style: TextStyle(
                              fontSize: 14.fss,
                              fontFamily: 'MontserratBold',
                              color: const Color.fromARGB(255, 149, 178, 218),
                            ),
                          ),
                        ]),
                  )),
            )
          : null,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: widget.getListBasket.call()?.length ?? 0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: const BorderSide(color: Colors.black)),
                      color: Color.fromARGB(255, 54, 54, 54),
                      child: InkWell(
                          customBorder: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onLongPress: widget.getListBasket
                                          .call()![index]!
                                          .shopItemCount! <=
                                      widget.getListBasket
                                          .call()![index]!
                                          .item_Count! &&
                                  widget.getListBasket
                                          .call()![index]!
                                          .shopItemCount! !=
                                      0
                              ? () => onLongPress(index)
                              : () => null,
                          onTap: () {
                            setState(() {
                              if (isSelected &&
                                  widget.getListBasket
                                          .call()![index]!
                                          .shopItemCount! <=
                                      widget.getListBasket
                                          .call()![index]!
                                          .item_Count! &&
                                  widget.getListBasket
                                          .call()![index]!
                                          .shopItemCount! !=
                                      0) {
                                onLongPress(index);
                              } else {
                                //openItem
                              }
                            });
                          },
                          child: Stack(children: [
                            Column(
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                        ),
                                        child: SizedBox.fromSize(
                                          size: Size.fromRadius(70),
                                          child: Image.network(
                                              '${widget.getListBasket.call()?[index]!.image_URL}',
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 5, 0, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 10),
                                              child: Text(
                                                "${double.parse((widget.getListBasket.call()![index]!.item_Price! * widget.getListBasket.call()![index]!.shopItemCount!).toStringAsFixed(2))}₽",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 17.fss,
                                                  fontFamily: 'MontserratBold',
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Divider(
                                                color: Color.fromARGB(
                                                    255, 56, 124, 220),
                                                thickness: 2,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(
                                                  "${widget.getListBasket.call()?[index]!.item_Name}",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 18.fss,
                                                    fontFamily:
                                                        'MontserratBold',
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              child: Align(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: "Артикул:",
                                                    style: TextStyle(
                                                      fontSize: 13.fss,
                                                      fontFamily:
                                                          'MontserratLight',
                                                      color: Colors.white,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              ' ${widget.getListBasket.call()?[index]!.item_id}',
                                                          style: TextStyle(
                                                            fontSize: 13.fss,
                                                            fontFamily:
                                                                'MontserratBold',
                                                            color: Colors.white,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Row(children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.26,
                                            child: Text(
                                              "${widget.getListBasket.call()?[index]!.item_Price}₽",
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
                                                  color: widget.getListBasket
                                                                  .call()![
                                                                      index]!
                                                                  .item_Count! <
                                                              10 &&
                                                          widget.getListBasket
                                                                  .call()![
                                                                      index]!
                                                                  .item_Count! >
                                                              0
                                                      ? Color.fromARGB(
                                                          255, 255, 200, 2)
                                                      : widget.getListBasket
                                                                  .call()?[
                                                                      index]!
                                                                  .item_Count! ==
                                                              0
                                                          ? Color.fromARGB(
                                                              255, 255, 67, 67)
                                                          : Color.fromARGB(255,
                                                              142, 255, 185)),
                                            ),
                                            Text(
                                              "${widget.getListBasket.call()?[index]!.item_Count}шт. в нал.",
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
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: InkWell(
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color:
                                                Color.fromARGB(255, 28, 55, 92),
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: Color.fromARGB(
                                                255, 149, 178, 218),
                                            size: 36.ss,
                                          ),
                                        ),
                                        onTap: () async {
                                          var temp = widget.getListBasket
                                              .call()![index]!;
                                          if (widget.getListBasket
                                                  .call()![index]!
                                                  .shopItemCount! >
                                              widget.getListBasket
                                                  .call()![index]!
                                                  .item_Count!) {
                                            var tempValue;
                                            setState(() {
                                              tempValue = temp.shopItemCount;
                                              temp.shopItemCount =
                                                  temp.item_Count;
                                            });
                                            if (!await ApiService()
                                                .PutBasket(temp)) {
                                              temp.shopItemCount = tempValue;
                                            }
                                          }
                                          if (widget.getListBasket
                                                  .call()![index]!
                                                  .shopItemCount! >
                                              1) {
                                            setState(() {
                                              temp.shopItemCount =
                                                  temp.shopItemCount! - 1;
                                            });
                                            if (!await ApiService()
                                                .PutBasket(temp)) {
                                              temp.shopItemCount =
                                                  temp.shopItemCount! + 1;
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      alignment: Alignment.center,
                                      child: Text(
                                          "${widget.getListBasket.call()?[index]!.shopItemCount} шт.",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 18.fss,
                                            fontFamily: 'MontserratLight',
                                            color: Colors.white,
                                          )),
                                    ),
                                    InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          color:
                                              Color.fromARGB(255, 28, 55, 92),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Color.fromARGB(
                                              255, 149, 178, 218),
                                          size: 36.ss,
                                        ),
                                      ),
                                      onTap: () async {
                                        if (widget.getListBasket
                                                .call()![index]!
                                                .shopItemCount! <
                                            widget.getListBasket
                                                .call()![index]!
                                                .item_Count!) {
                                          var temp = widget.getListBasket
                                              .call()![index]!;
                                          setState(() {
                                            temp.shopItemCount =
                                                temp.shopItemCount! + 1;
                                          });
                                          if (!await ApiService()
                                              .PutBasket(temp)) {
                                            setState(() {
                                              temp.shopItemCount =
                                                  temp.shopItemCount! - 1;
                                            });
                                          }
                                        }
                                      },
                                    ),
                                    isSelected == true
                                        ? Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                70, 0, 0, 3),
                                            child: Icon(
                                              widget.getListBasket
                                                          .call()?[index]!
                                                          .isSelected ==
                                                      false
                                                  ? Icons
                                                      .check_box_outline_blank_outlined
                                                  : Icons.check_box_outlined,
                                              color: Color.fromARGB(
                                                  255, 149, 178, 218),
                                              size: 30.ss,
                                            ))
                                        : Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                12, 0, 0, 0),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.23,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              child: OutlinedButton(
                                                  onPressed: () {
                                                    //покупка на один предмет
                                                  },
                                                  style: OutlinedButton.styleFrom(
                                                      primary: Colors.white,
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255, 28, 55, 92),
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20)))),
                                                  child: Text(
                                                    "Купить",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 13.fss,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              149,
                                                              178,
                                                              218),
                                                      fontFamily:
                                                          'MontserratBold',
                                                    ),
                                                  )),
                                            ),
                                          ),
                                  ]),
                                ),
                              ],
                            ),
                            widget.getListBasket.call()?[index]!.isSelected ==
                                    true
                                ? Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color:
                                              Color.fromARGB(22, 43, 82, 136),
                                          border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 43, 82, 136),
                                              width: 3)),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ])),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
