import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../Models/ShopClasses.dart';

class HistoryPage extends StatefulWidget {
  final void Function(bool) callback;
  final ValueGetter<List<BasketFullInfo>?> getListBasket;
  final ValueGetter<List<ShopOrderFullInfo>?>? listShopOrders;
  const HistoryPage(
      {super.key,
      required this.callback,
      required this.getListBasket,
      required this.listShopOrders});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          width: 1,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: widget.listShopOrders!.call()?.length ?? 0,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(children: [
                    Text("${widget.listShopOrders!.call()![index].id_Order}"),
                  ]),
                );
              }),
        ),
      ]),
    );
  }
}
