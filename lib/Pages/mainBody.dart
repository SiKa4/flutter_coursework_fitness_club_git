import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'homeImageView.dart';

class MainBody extends StatefulWidget {
  const MainBody({super.key});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  PageController _controller = PageController();
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Stack(alignment: Alignment.bottomRight, children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: PageView(
            controller: _controller,
            children: const [
              homeImageView(
                "Фитнес-клуб - 'GLY UP'",
                "assets/images/1fit.jpg",
              ),
              homeImageView(
                "Передовые тренажеры для мужчин и для женщин",
                "assets/images/2fit.jpg",
              ),
              homeImageView(
                "Доступно более чем 100 беговых дорожек",
                "assets/images/3fit.jpg",
              ),
              homeImageView(
                "Приятная и дружелюбная атмосфера",
                "assets/images/4fit.jpg",
              ),
              homeImageView(
                "Отдельный зал для работы с железом",
                "assets/images/5fit.jpg",
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: SmoothPageIndicator(
            controller: _controller,
            effect:
                WormEffect(activeDotColor: Color.fromARGB(255, 58, 111, 185)),
            count: 5,
          ),
        )
      ]),
      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.04,
        width: MediaQuery.of(context).size.width * 0.75,
        child: OutlinedButton.icon(
          // ignore: sort_child_properties_last
          label: const Text(
            'Личный кабинет',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 149, 178, 218),
              fontFamily: 'MontserratBold',
            ),
          ),
          icon: Icon(
            Icons.account_box,
            color: Color.fromARGB(255, 149, 178, 218),
          ),
          style: OutlinedButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Color.fromARGB(255, 28, 55, 92),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          onPressed: () {Navigator.popAndPushNamed(context, '/test');},
        ),
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.45,
            child: OutlinedButton.icon(
              // ignore: sort_child_properties_last
              label: const Text(
                "Магазин",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 149, 178, 218),
                  fontFamily: 'MontserratBold',
                ),
              ),
              icon: Icon(
                Icons.shopping_cart,
                color: Color.fromARGB(255, 149, 178, 218),
              ),
              style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromARGB(255, 28, 55, 92),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.45,
            child: OutlinedButton.icon(
              // ignore: sort_child_properties_last
              label: const Text(
                'Обратный звонок',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 149, 178, 218),
                  fontFamily: 'MontserratBold',
                ),
              ),
              icon: Icon(
                Icons.add_ic_call,
                color: Color.fromARGB(255, 149, 178, 218),
              ),
              style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color.fromARGB(255, 28, 55, 92),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () {},
            ),
          ),
        ],
      )
    ]);
  }
}
