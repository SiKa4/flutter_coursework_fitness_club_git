import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_coursework_fitness_club/HTTP_Connections/http_model.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizing/sizing.dart';

import '../../../Models/ScheduleСlassesUsers.dart';

class MySchedulesBody extends StatefulWidget {
  const MySchedulesBody({super.key});

  @override
  State<MySchedulesBody> createState() => _MySchedulesBodyState();
}

class _MySchedulesBodyState extends State<MySchedulesBody> {
  bool isLoading = false;
  List<ScheduleClassesUsersFullInfo>? sheduleClassesUsersFullInfo;

  @override
  void initState() {
    isLoading = true;
    //asyncInitState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethodGet();
    });
  }

  _asyncMethodGet() async {
    sheduleClassesUsersFullInfo = (await ApiService()
            .GetAllUserSchedulesAndFullInfo(ApiService.user.id_User))
        as List<ScheduleClassesUsersFullInfo>?;
    //---------
    setState(() {
      isLoading = false;
    });
  }

  void ShowToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ));
  }

  Widget getBlockDateTime(int index) {
    if (blockDateTime == null ||
        DateFormat('yyyy-MM-dd').format(blockDateTime!) !=
            DateFormat('yyyy-MM-dd').format(
                sheduleClassesUsersFullInfo?[index].timeStart as DateTime)) {
      blockDateTime = sheduleClassesUsersFullInfo?[index].timeStart;
      return Column(children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          height: MediaQuery.of(context).size.height * 0.03,
          width: MediaQuery.of(context).size.width * 0.35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color.fromARGB(255, 54, 54, 54)),
          child: Center(
            child: Text(
              "${DateFormat('MMMMd').format(sheduleClassesUsersFullInfo?[index].timeStart as DateTime)}",
              style: TextStyle(
                fontSize: 20.fss,
                fontFamily: 'MontserratBold',
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ]);
    } else
      return SizedBox.shrink();
  }

  DateTime? blockDateTime;

  void ShowBottomSheet(
      ScheduleClassesUsersFullInfo scheduleUserFullInfo, int index) {
    showModalBottomSheet<void>(
        context: context,
        barrierColor: Colors.black45,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter mystate) {
            return FractionallySizedBox(
              heightFactor: 0.27,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.73,
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
                      Text(
                        "${scheduleUserFullInfo.type_Name}",
                        style: TextStyle(
                          fontSize: 24.fss,
                          fontFamily: 'MontserratBold',
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Divider(
                          color: Color.fromARGB(255, 56, 124, 220),
                          thickness: 1.3,
                        ),
                      ),
                      Text(
                        "Начало: ${DateFormat('kk:mm').format(scheduleUserFullInfo.timeStart as DateTime)} (${scheduleUserFullInfo.timeDuration?.inMinutes} мин)",
                        style: TextStyle(
                          fontSize: 20.fss,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_downward_sharp,
                        color: Color.fromARGB(255, 56, 124, 220),
                        size: 30.0,
                      ),
                      Text(
                        "Конец: ${DateFormat('kk:mm').format(scheduleUserFullInfo.timeEnd as DateTime)}",
                        style: TextStyle(
                          fontSize: 20.fss,
                          fontFamily: 'MontserratLight',
                          color: Colors.white,
                        ),
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
                            'Отменить запись',
                            style: TextStyle(
                              fontSize: 17.fss,
                              color: Color.fromARGB(255, 149, 178, 218),
                              fontFamily: 'MontserratBold',
                            ),
                          ),
                          icon: Icon(
                            Icons.close,
                            color: Color.fromARGB(255, 149, 178, 218),
                          ),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Color.fromARGB(255, 28, 55, 92),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onPressed: () async {
                            scheduleUserFullInfo.isActiveUser = false;
                            ScheduleClassesUsersFullInfo answer =
                                await ApiService()
                                        .PutSchedulesUsers(scheduleUserFullInfo)
                                    as ScheduleClassesUsersFullInfo;
                            Navigator.pop(context);
                            setState(() {
                              if (answer != null) {
                                sheduleClassesUsersFullInfo?[index] = answer;
                                blockDateTime = null;
                                ShowToast("Вы успешно отменили запись!");
                              } else {
                                ShowToast("Произошла ошибка!");
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        ListView.builder(
           padding: EdgeInsets.only(top: 5),
          itemCount: sheduleClassesUsersFullInfo?.length ?? 0,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (sheduleClassesUsersFullInfo![index].isActive! &&
                sheduleClassesUsersFullInfo![index].isActiveUser!) {
              return Column(children: [
                getBlockDateTime(index),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.black)),
                  color: sheduleClassesUsersFullInfo![index].isActive! &&
                          sheduleClassesUsersFullInfo![index].isActiveUser!
                      ? Color.fromARGB(255, 54, 54, 54)
                      : Color.fromARGB(255, 37, 37, 37),
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onTap: () => {
                      if (sheduleClassesUsersFullInfo![index].isActive! &&
                          sheduleClassesUsersFullInfo![index].isActiveUser!)
                        {
                          ShowBottomSheet(
                              sheduleClassesUsersFullInfo![index], index)
                        }
                      else
                        {
                          ShowToast(
                              "Вы больше не можете просмотреть детали мероприятия!")
                        }
                    },
                    child: Row(children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.05),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${DateFormat('MMMMd').format(sheduleClassesUsersFullInfo?[index].timeStart as DateTime)}",
                              style: TextStyle(
                                fontSize: 20.fss,
                                fontFamily: 'MontserratBold',
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.005,
                                width: MediaQuery.of(context).size.width *
                                    0.05),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.24,
                              height:
                                  MediaQuery.of(context).size.height * 0.05,
                              child: Text(
                                "${DateFormat('kk:mm ' + '\n' + ' (${sheduleClassesUsersFullInfo?[index].timeDuration?.inMinutes} мин)').format(sheduleClassesUsersFullInfo?[index].timeStart as DateTime)}",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.7.fss,
                                  fontFamily: 'MontserratLight',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ]),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${sheduleClassesUsersFullInfo?[index].type_Name}",
                            style: TextStyle(
                                fontSize: 22.fss,
                                color: Colors.white,
                                fontFamily: 'MontserratBold'),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${sheduleClassesUsersFullInfo?[index].location}",
                            style: TextStyle(
                                fontSize: 17.7.fss,
                                color: Colors.white,
                                fontFamily: 'MontserratLight'),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Divider(
                              color: Color.fromARGB(255, 56, 124, 220),
                              thickness: 1.3,
                            ),
                          ),
                          Text(
                            "${sheduleClassesUsersFullInfo?[index].teacher_FullName}",
                            style: TextStyle(
                                fontSize: 14.4.fss,
                                color: Colors.white,
                                fontFamily: 'MontserratLight'),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ]);
            } else {
              return SizedBox.shrink();
            }
          },
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
