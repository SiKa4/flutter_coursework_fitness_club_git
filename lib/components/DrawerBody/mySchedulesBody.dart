import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_coursework_fitness_club/HTTP_Connections/http_model.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Models/ScheduleСlassesUsers.dart';

class MySchedulesBody extends StatefulWidget {
  const MySchedulesBody({super.key});

  @override
  State<MySchedulesBody> createState() => _MySchedulesBodyState();
}

class _MySchedulesBodyState extends State<MySchedulesBody> {
  bool isLoading = false;
  List<ScheduleClassesUsersFullInfo>? sheduleClassesUsersFullInfo;
  List<ScheduleClassesUsersFullInfo>? mainSheduleClassesUsersFullInfo;

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
    mainSheduleClassesUsersFullInfo = (await ApiService()
            .GetAllUserSchedulesAndFullInfo(ApiService.user.id_User))
        as List<ScheduleClassesUsersFullInfo>?;
    sheduleClassesUsersFullInfo = mainSheduleClassesUsersFullInfo;
    //---------
    setState(() {
      isLoading = false;
    });
  }

  void ShowToast(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget getBlockDateTime(int index) {
    if (blockDateTime != sheduleClassesUsersFullInfo?[index].timeStart) {
      blockDateTime = sheduleClassesUsersFullInfo?[index].timeStart;
      return Column(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.01),
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
                fontSize: 20.0,
                fontFamily: 'MontserratBold',
                color: Colors.white,
              ),
            ),
          ),
        ),
         SizedBox(
            height: MediaQuery.of(context).size.height * 0.01),
      ]);
    } else
      return SizedBox.shrink();
  }

  DateTime? blockDateTime;

  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Column(children: [SizedBox(
            height: MediaQuery.of(context).size.height * 0.007),
          Expanded(
            child: ListView.builder(
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
                            {}
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
                                    fontSize: 20.0,
                                    fontFamily: 'MontserratBold',
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.005,
                                    width: MediaQuery.of(context).size.width *
                                        0.05),
                                Text(
                                  "${DateFormat('kk:mm (${sheduleClassesUsersFullInfo?[index].timeDuration?.inMinutes} мин)').format(sheduleClassesUsersFullInfo?[index].timeStart as DateTime)}",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'MontserratLight',
                                    color: Colors.white,
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
                                style: const TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                    fontFamily: 'MontserratBold'),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "${sheduleClassesUsersFullInfo?[index].location}",
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
                                "${sheduleClassesUsersFullInfo?[index].teacher_FullName}",
                                style: const TextStyle(
                                    fontSize: 15.0,
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
                } else{ return SizedBox.shrink();}
              },
            ),
          ),
        ]),
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
