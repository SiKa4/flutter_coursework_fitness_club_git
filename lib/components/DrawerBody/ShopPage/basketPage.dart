import 'package:flutter/cupertino.dart';

class BasketPage extends StatefulWidget {
  final void Function(bool) callback;
  const BasketPage({super.key, required this.callback});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
