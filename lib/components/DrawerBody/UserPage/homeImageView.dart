import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class homeImageView extends StatelessWidget {
  const homeImageView(this.heading, this.image, {super.key});
  final String heading;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(alignment: Alignment.bottomLeft, children: [
          Image.asset(image,
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width),
          Positioned.fill(child: Container(color: Colors.black38)),
          Text(
            heading,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 25.0,
              fontFamily: 'MontserratLight',
              color: Color.fromARGB(255, 220, 220, 220),
            ),
          ),
        ]),
      ),
    );
  }
}

class itemImageView extends StatelessWidget {
  const itemImageView(this.image, {super.key});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(alignment: Alignment.bottomLeft, children: [
          Positioned.fill(
              child: Container(
                  color: Color.fromARGB(255, 255, 255, 255),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width)),
          Image.network(image,
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width),
        ]),
      ),
    );
  }
}
