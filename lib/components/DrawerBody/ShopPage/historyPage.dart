import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizing/sizing.dart';

import '../../../Models/ShopClasses.dart';

class HistoryPage extends StatefulWidget {
  final void Function(bool) callback;
  final ValueGetter<List<BasketFullInfo>?> getListBasket;
  const HistoryPage({
    super.key,
    required this.callback,
    required this.getListBasket,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
