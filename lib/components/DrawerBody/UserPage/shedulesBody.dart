import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sizing/sizing.dart';

import '../../../HTTP_Connections/http_model.dart';
import '../../../Models/ScheduleСlassesUsers.dart';
import '../../../Models/SheduleClassesAndTypes.dart';

class ShedulesPage extends StatefulWidget {
  const ShedulesPage({super.key});

  @override
  State<ShedulesPage> createState() => _ShedulesPageState();
}

class _ShedulesPageState extends State<ShedulesPage> {
  List<SheduleClassesAndTypes>? sheduleClassesAndTypes;
  List<SheduleClassesAndTypes>? mainSheduleClassesAndTypes;
  List<ScheduleClassesUsersFullInfo>? sheduleClassesUsersFullInfo;
  List<DateInApi>? dateInApi;
  int _selectedDayIndex = 0;
  bool isLoading = false;

  void ShowBottomSheet(
      SheduleClassesAndTypes sheduleClassesAndTypes, int index) {
    showModalBottomSheet<void>(
        context: context,
        barrierColor: Colors.black45,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) {
            return FractionallySizedBox(
              heightFactor: 0.55,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 48, 48, 48),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(
                          "${sheduleClassesAndTypes.type_Name}",
                          style: TextStyle(
                            fontSize: 24.fss,
                            fontFamily: 'MontserratBold',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Divider(
                          color: Color.fromARGB(255, 56, 124, 220),
                          thickness: 2,
                        ),
                      ),
                      Text(
                        "Начало: ${DateFormat('kk:mm').format(sheduleClassesAndTypes.timeStart as DateTime)} (${sheduleClassesAndTypes.timeDuration?.inMinutes} минут)",
                        style: TextStyle(
                          fontSize: 20.fss,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_downward_sharp,
                        color: Color.fromARGB(255, 56, 124, 220),
                        size: 34.ss,
                      ),
                      Text(
                        "Конец: ${DateFormat('kk:mm').format(sheduleClassesAndTypes.timeEnd as DateTime)}",
                        style: TextStyle(
                          fontSize: 20.fss,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
                      ),
                       SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Divider(
                          color: Color.fromARGB(255, 56, 124, 220),
                          thickness: 1.3,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: OutlinedButton.icon(
                          // ignore: sort_child_properties_last
                          label: Text(
                            'Записаться',
                            style: TextStyle(
                              fontSize: 19.fss,
                              color: Color.fromARGB(255, 149, 178, 218),
                              fontFamily: 'MontserratBold',
                            ),
                          ),
                          icon: Icon(
                            Icons.add_box_outlined,
                            color: Color.fromARGB(255, 149, 178, 218),
                            size: 24.ss,
                          ),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Color.fromARGB(255, 28, 55, 92),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onPressed: () async {
                            var isWrite = await ApiService()
                                .setScheduleClassAndUser(
                                    sheduleClassesAndTypes.id_ScheduleClass!,
                                    ApiService.user.id_User);
                            Navigator.pop(context);
                            if (isWrite == null)
                              ShowToast("Произошла ошибка!");
                            else {
                              ShowToast("Вы успешно записаны на занятие!");
                              sheduleClassesUsersFullInfo!.add(isWrite);
                            }
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Divider(
                          color: Color.fromARGB(255, 56, 124, 220),
                          thickness: 1.3,
                        ),
                      ),
                       SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Кабинет: ${sheduleClassesAndTypes.location}",
                        style: TextStyle(
                          fontSize: 18.fss,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Text(
                        "Преподаватель: ${sheduleClassesAndTypes.teacher_FullName}",
                        style: TextStyle(
                          fontSize: 16.fss,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.93,
                        child: Divider(
                          color: Color.fromARGB(255, 56, 124, 220),
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Text(
                          "${sheduleClassesAndTypes.details}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 13.fss,
                            fontFamily: 'MontserratLight',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(20),
                      //   child: SizedBox.fromSize(
                      //     child: Image.network(
                      //       '${sheduleClassesAndTypes.image_Type}',
                      //       fit: BoxFit.fill,
                      //       height: 150.ss,
                      //       width: MediaQuery.of(context).size.width,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  void initState() {
    isLoading = true;
    asyncInitState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethodGet();
    });
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
    if (!isEmpty) {
      int? index = mainSheduleClassesAndTypes?.indexOf(
          mainSheduleClassesAndTypes!
              .where((element) =>
                  element.id_ScheduleClass ==
                  sheduleClasseAndType.id_ScheduleClass)
              .first);
      if (sheduleClasseAndType!.isDelete) {
        mainSheduleClassesAndTypes?.remove(mainSheduleClassesAndTypes![index!]);
      } else {
        mainSheduleClassesAndTypes?[index!] = sheduleClasseAndType;
      }
    }
    if (isEmpty) {
      mainSheduleClassesAndTypes?.add(sheduleClasseAndType);
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
    sheduleClassesUsersFullInfo = (await ApiService()
                .GetAllUserSchedulesAndFullInfo(ApiService.user.id_User))
            as List<ScheduleClassesUsersFullInfo>? ??
        <ScheduleClassesUsersFullInfo>[];
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
    setState(() {
      isLoading = false;
    });
  }

  void ShowToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)));
  }

  Widget cardList(int index) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.black)),
      color: Color.fromARGB(255, 54, 54, 54),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onTap: () {
          if (sheduleClassesUsersFullInfo!
              .where((x) =>
                  x.scheduleClass_id ==
                      sheduleClassesAndTypes![index].id_ScheduleClass &&
                  x.isActiveUser == true)
              .isNotEmpty) {
            ShowToast("Вы уже записаны на это занятие!");
            return;
          }
          if (sheduleClassesAndTypes![index].isActive!) {
            ShowBottomSheet(sheduleClassesAndTypes![index], index);
          } else if (sheduleClassesAndTypes![index].isActive!) {
            ShowToast("Запись на данное занятие прекращена!");
          }
        },
        child: Row(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.05),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Text(
                DateFormat('kk:mm').format(
                    sheduleClassesAndTypes?[index].timeStart ?? DateTime.now()),
                style: TextStyle(
                    fontSize: 24.fss,
                    color: Colors.white,
                    fontFamily: 'MontserratBold'),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                  width: MediaQuery.of(context).size.width * 0.05),
              Text(
                "${sheduleClassesAndTypes?[index].timeDuration?.inMinutes} мин",
                style: TextStyle(
                    fontSize: 16.fss,
                    color: Colors.white,
                    fontFamily: 'MontserratLight'),
              ),
            ]),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${sheduleClassesAndTypes?[index].type_Name}",
                  style: TextStyle(
                      fontSize: 22.fss,
                      color: Colors.white,
                      fontFamily: 'MontserratBold'),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${sheduleClassesAndTypes?[index].location}",
                  style: TextStyle(
                      fontSize: 17.7.fss,
                      color: Colors.white,
                      fontFamily: 'MontserratLight'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Divider(
                    color: sheduleClassesUsersFullInfo!
                            .where((x) =>
                                x.scheduleClass_id ==
                                    sheduleClassesAndTypes![index]
                                        .id_ScheduleClass &&
                                x.isActiveUser == true)
                            .isNotEmpty
                        ? Color.fromARGB(255, 142, 255, 185)
                        : Color.fromARGB(255, 56, 124, 220),
                    thickness: 1.3,
                  ),
                ),
                Text(
                  "${sheduleClassesAndTypes?[index].teacher_FullName}",
                  style: TextStyle(
                      fontSize: 16.5.fss,
                      color: Colors.white,
                      fontFamily: 'MontserratLight'),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Icon(
                sheduleClassesAndTypes![index].isActive!
                    ? Icons.beenhere_outlined
                    : Icons.block_outlined,
                color: sheduleClassesUsersFullInfo!
                        .where((x) =>
                            x.scheduleClass_id ==
                                sheduleClassesAndTypes![index]
                                    .id_ScheduleClass &&
                            x.isActiveUser == true)
                        .isNotEmpty
                    ? Color.fromARGB(255, 142, 255, 185)
                    : Color.fromARGB(255, 56, 124, 220),
                size: 33.ss,
              ),
            ),
          ],
        ),
      ),
    );
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
              height: 50.ss,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // itemScrollController: itemScrollController,
                // itemPositionsListener: itemPositionsListener,
                itemCount: dateInApi?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
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
                      padding: EdgeInsets.symmetric(horizontal: 25.ss),
                      alignment: Alignment.center,
                      color:
                          index == _selectedDayIndex ? Colors.grey[800] : null,
                      child: Column(
                        children: [
                          Text(
                            "${DateFormat('EE').format(dateInApi?[index].date as DateTime)}",
                            style: TextStyle(
                              fontSize: 22.fss,
                              fontFamily: 'MontserratLight',
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${DateFormat('MMMMd').format(dateInApi![index].date as DateTime)}",
                            style: TextStyle(
                              fontSize: 15.fss,
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
                  if (sheduleClassesAndTypes![index].isActive!) {
                    return cardList(index);
                  } else {
                    return Stack(children: [
                      cardList(index),
                      Positioned.fill(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.977,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(149, 25, 25, 25),
                          ),
                        ),
                      ),
                    ]);
                  }
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
                  size: 50.ss,
                ))
            : SizedBox.shrink()
      ]),
    );
  }
}
