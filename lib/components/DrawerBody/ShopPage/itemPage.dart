import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../HTTP_Connections/http_model.dart';
import '../../../Models/ScheduleСlassesUsers.dart';
import '../../../Models/ShopClasses.dart';
import '../UserPage/homeImageView.dart';

class ItemPage extends StatefulWidget {
  final void Function(bool) callback;
  const ItemPage({super.key, required this.callback});

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

  void ShowBottomSheet(Item item) {
    showModalBottomSheet<void>(
        context: context,
        barrierColor: Colors.black45,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) {
            return FractionallySizedBox(
              heightFactor: 0.83,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.83,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 48, 48),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Text(
                          "${item.shopItemName}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.0,
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
                                    fontSize: 18.0,
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
                        color: Color.fromARGB(255, 56, 124, 220),
                        thickness: 2,
                      ),
                    ),
                    Text(
                      "${item.price}₽",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 26.0,
                        fontFamily: 'MontserratBold',
                        color: Colors.white,
                      ),
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
                  ShowBottomSheet(listItem![index]);
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
              ),
            );
          }),
    );
  }
}
