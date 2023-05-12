import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../../../Models/ShopClasses.dart';

class BasketPage extends StatefulWidget {
  const BasketPage(
      {super.key, required this.getListBasket, required this.showToast});
  final ValueGetter<List<BasketFullInfo?>?> getListBasket;
  final void Function(String) showToast;
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
                        onTap: () {},
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          child: Text(
                                            "${widget.getListBasket.call()?[index]!.item_Name}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 18.fss,
                                              fontFamily: 'MontserratBold',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: Align(
                                            child: RichText(
                                              text: TextSpan(
                                                text: "Артикул:",
                                                style: TextStyle(
                                                  fontSize: 13.fss,
                                                  fontFamily: 'MontserratLight',
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                              .call()![index]!
                                                              .item_Count! <
                                                          10 &&
                                                      widget.getListBasket
                                                              .call()![index]!
                                                              .item_Count! >
                                                          0
                                                  ? Color.fromARGB(
                                                      255, 255, 200, 2)
                                                  : widget.getListBasket
                                                              .call()?[index]!
                                                              .item_Count! ==
                                                          0
                                                      ? Color.fromARGB(
                                                          255, 255, 67, 67)
                                                      : Color.fromARGB(
                                                          255, 142, 255, 185)),
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
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Color.fromARGB(255, 28, 55, 92),
                                      ),
                                      child: Icon(
                                        Icons.remove,
                                        color:
                                            Color.fromARGB(255, 149, 178, 218),
                                        size: 36.ss,
                                      ),
                                    ),
                                    onTap: () {
                                      //if (widget.getListBasket.call()?[index]!.shopItemCount > 1)
                                    },
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                    // if (cntItem < item.itemCount!)
                                    //   mystate(() {
                                    //     cntItem++;
                                    //   });
                                  },
                                ),
                              ]),
                            ),
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
