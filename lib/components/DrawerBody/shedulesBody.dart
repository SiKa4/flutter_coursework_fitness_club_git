import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../HTTP_Connections/http_model.dart';
import '../../Models/SheduleClassesAndTypes.dart';

class ShedulesPage extends StatefulWidget {
  const ShedulesPage({super.key});

  @override
  State<ShedulesPage> createState() => _ShedulesPageState();
}

class _ShedulesPageState extends State<ShedulesPage> {
  List<SheduleClassesAndTypes>? sheduleClassesAndTypes;
  List<SheduleClassesAndTypes>? mainSheduleClassesAndTypes;
  List<DateInApi>? dateInApi;
  int _selectedDayIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    asyncInitState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethodGet();
    });
    isLoading = false;
  }

  Future<void> asyncInitState() async {
    await ApiService.GetNewShedulesAndFullInfo();
    initSession();
  }

  void initSession() async {
    await ApiService.hubConnection
        .on("GetShedules", _handleAClientProvidedFunction);
  }

  void _handleAClientProvidedFunction(var parameters) {
    var sheduleClasseAndType = SheduleClassesAndTypes.fromJson(parameters[0]);
    bool? isEmpty = mainSheduleClassesAndTypes!
        .where((element) =>
            element.id_ScheduleClass == sheduleClasseAndType.id_ScheduleClass)
        .isEmpty;
    if (isEmpty) {
      mainSheduleClassesAndTypes?.add(sheduleClasseAndType);
    } else {
      int? index = mainSheduleClassesAndTypes?.indexOf(
          mainSheduleClassesAndTypes!
              .where((element) =>
                  element.id_ScheduleClass ==
                  sheduleClasseAndType.id_ScheduleClass)
              .first);
      mainSheduleClassesAndTypes?[index!] = sheduleClasseAndType;
    }
    sheduleClassesAndTypes = mainSheduleClassesAndTypes
          ?.where((x) =>
              DateFormat('yMMMMd').format(x.timeStart as DateTime) ==
              DateFormat('yMMMMd').format(
                  dateInApi?.elementAt(_selectedDayIndex).date as DateTime))
          .toList();
    setState(() {});
  }

  _asyncMethodGet() async {
    mainSheduleClassesAndTypes = (await ApiService()
        .GetAllShedulesAndFullInfo()) as List<SheduleClassesAndTypes>?;
    dateInApi = (await ApiService().GetAllDateWeek()) as List<DateInApi>?;
    _selectedDayIndex = dateInApi?.indexOf(
            dateInApi!.where((x) => x.date?.day == DateTime.now().day).first) ??
        0;
    sheduleClassesAndTypes = mainSheduleClassesAndTypes
        ?.where((x) =>
            DateFormat('yMMMMd').format(x.timeStart as DateTime) ==
            DateFormat('yMMMMd').format(
                dateInApi?.elementAt(_selectedDayIndex).date as DateTime))
        .toList();
    setState(() {});
  }

  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
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
                // itemScrollController: itemScrollController,
                // itemPositionsListener: itemPositionsListener,
                itemCount: dateInApi?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        sheduleClassesAndTypes = mainSheduleClassesAndTypes
                            ?.where((x) =>
                                DateFormat('yMMMMd')
                                    .format(x.timeStart as DateTime) ==
                                DateFormat('yMMMMd').format(dateInApi
                                    ?.elementAt(index)
                                    .date as DateTime))
                            .toList();
                      });
                      _selectedDayIndex = index;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      alignment: Alignment.center,
                      color:
                          index == _selectedDayIndex ? Colors.grey[800] : null,
                      child: Column(
                        children: [
                          Text(
                            "${DateFormat('EE').format(dateInApi?[index].date as DateTime)}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'MontserratLight',
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${DateFormat('MMMMd').format(dateInApi![index].date as DateTime)}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'MontserratLight',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                              "${sheduleClassesAndTypes?[index].timeDuration?.inMinutes} мин",
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
