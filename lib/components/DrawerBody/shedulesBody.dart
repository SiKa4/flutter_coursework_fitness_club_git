import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../HTTP_Connections/http_model.dart';
import '../../Models/SheduleClassesAndTypes.dart';

class ShedulesPage extends StatefulWidget {
  const ShedulesPage({super.key});

  @override
  State<ShedulesPage> createState() => _ShedulesPageState();
}

class _ShedulesPageState extends State<ShedulesPage> {
  int _selectedDayIndex = 0;
  List<SheduleClassesAndTypes>? sheduleClassesAndTypes;
  bool isLoading = false;
  @override
  void initState() {
    isLoading = true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethodGet();
    });
  }

  _asyncMethodGet() async {
    sheduleClassesAndTypes = (await ApiService().GetAllShedulesAndFullInfo())
        as List<SheduleClassesAndTypes>?;
    setState(() {});
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Column(
          children: <Widget>[
            Container(
              height: 50.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                //itemCount: daysOfWeek.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: Alignment.center,
                      color:
                          index == _selectedDayIndex ? Colors.grey[800] : null,
                      // child: Text(
                      //   daysOfWeek[index],
                      //   style: TextStyle(
                      //     fontSize: 18.0,
                      //     fontFamily: 'MontserratLight',
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sheduleClassesAndTypes?.length ?? 0,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: const BorderSide(color: Colors.black)),
                    color: Color.fromARGB(255, 54, 54, 54),
                    child: Row(children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.05),
                      Column(crossAxisAlignment: CrossAxisAlignment.center,children: [
                        Text(
                          DateFormat('kk:mm').format(
                              sheduleClassesAndTypes?[index].timeStart ??
                                  DateTime.now()),
                          style: const TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                              fontFamily: 'MontserratBold'),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                           "${sheduleClassesAndTypes?[index]
                                  .timeDuration
                                  ?.inMinutes} мин",
                          style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontFamily: 'MontserratLight'),
                        ),
                      ]),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.07),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${sheduleClassesAndTypes?[index].type_Name}",
                            style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontFamily: 'MontserratBold'),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${sheduleClassesAndTypes?[index].location}",
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: 'MontserratLight'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            width: 200,
                            child: Divider(
                              color: Color.fromARGB(255, 56, 124, 220),
                            ),
                          ),
                          Text(
                            "${sheduleClassesAndTypes?[index].teacher_FullName}",
                            style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                fontFamily: 'MontserratLight'),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ]),
                  );
                },
              ),
            ),
          ],
        ),
        isLoading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black45,
                child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.blue,
                  size: 50,
                ))
            : SizedBox.shrink()
      ]),
    );
  }
}
