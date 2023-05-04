import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HistoryPage extends StatefulWidget {
  final void Function(bool) callback;
  const HistoryPage({super.key, required this.callback});
  

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
