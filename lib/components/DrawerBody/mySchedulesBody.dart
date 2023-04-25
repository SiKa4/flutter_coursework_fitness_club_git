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
    //---------
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        itemCount: sheduleClassesUsersFullInfo?.length ?? 0,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.black)),
            color: sheduleClassesUsersFullInfo![index].isActive!
                ? Color.fromARGB(255, 54, 54, 54)
                : Color.fromARGB(255, 37, 37, 37),
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onTap: () => {
                //----------------
              },
              child: Row(children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.05),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('kk:mm').format(
                            sheduleClassesUsersFullInfo?[index].timeStart ??
                                DateTime.now()),
                        style: const TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontFamily: 'MontserratBold'),
                        textAlign: TextAlign.center,
                      ),
                      // Text(
                      //   "${sheduleClassesUsersFullInfo?[index].timeDuration?.inMinutes} мин",
                      //   style: const TextStyle(
                      //       fontSize: 18.0,
                      //       color: Colors.white,
                      //       fontFamily: 'MontserratLight'),
                      // ),
                    ]),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.07),
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
                )
              ]),
            ),
          );
        },
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
    ]);
  }
}
