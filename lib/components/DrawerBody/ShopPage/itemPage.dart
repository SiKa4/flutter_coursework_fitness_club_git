import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../HTTP_Connections/http_model.dart';
import '../../../Models/ShopClasses.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  List<Item>? listItem;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethodGet();
    });
    super.initState();
  }

  void _asyncMethodGet() async {
    listItem = await ApiService().GetAllItem() as List<Item>;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 350),
        itemCount: listItem?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color.fromARGB(255, 33, 33, 33))),
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
  }
}
