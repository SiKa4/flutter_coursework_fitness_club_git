import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? Color.fromARGB(255, 74, 99, 135) : Colors.transparent ,
                  width: 2,
                ),
              ),
        child: Row(
          children: [
            if (title != null)
              Container(
                  width: MediaQuery.of(context).size.width * 0.74,
                  child: title),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.04,
            ),
            _customRadioButton(context),
          ],
        ),
      ),
    );
  }

  Widget _customRadioButton(BuildContext context) {
    final isSelected = value == groupValue;
    return Container(
      height: MediaQuery.of(context).size.height * 0.025,
      width: MediaQuery.of(context).size.width * 0.05,
      decoration: BoxDecoration(
        color: isSelected ? Color.fromARGB(255, 28, 55, 92) : null,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey[300]!,
          width: 2,
        ),
      ),
    );
  }
}
