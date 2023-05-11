import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

class CustomDrawerHeader extends StatelessWidget {
  final bool isColapsed;

  const CustomDrawerHeader({
    Key? key,
    required this.isColapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: MediaQuery.of(context).size.height * 0.07,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Image.asset(
                "assets/images/logofitnes.png",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.3
              ),
          ), 
          if (isColapsed) const SizedBox(width: 10),
          if (isColapsed)
            Expanded(
              flex: 3,
              child: Text(
                'GLY UP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.fss,
                ),
                maxLines: 1,
              ),
            ),
          if (isColapsed) const Spacer(),
          if (isColapsed)
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
