import 'package:flutter/material.dart';
import 'package:flutter_coursework_fitness_club/HTTP_Connections/http_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizing/sizing.dart';

import '../../Animation/anim.dart';
import '../../Pages/profile.dart';

class BottomUserInfo extends StatelessWidget {
  final bool isCollapsed;

  const BottomUserInfo({
    Key? key,
    required this.isCollapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AlertDialogExit() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0, left: 5, right: 5),
              backgroundColor: Color.fromARGB(224, 61, 73, 91),
              content: Container(
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  children: [
                    Text(
                      "Вы уверены, что хотите выйти?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.fss,
                          color: Colors.white,
                          fontFamily: 'MontserratBold'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Icon(
                      Icons.exit_to_app_outlined,
                      color: Colors.white,
                      size: 30.ss,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: OutlinedButton(
                          // ignore: sort_child_properties_last
                          child: Text(
                            'Да',
                            style: TextStyle(
                              fontSize: 18.fss,
                              color: Color.fromARGB(255, 149, 178, 218),
                              fontFamily: 'MontserratBold',
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Color.fromARGB(255, 28, 55, 92),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onPressed: () async {
                            Navigator.pop(context);
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setInt('UserId', -1);
                            ApiService.user = null;
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/", (route) => false);
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: OutlinedButton(
                          // ignore: sort_child_properties_last
                          child: Text(
                            'Нет',
                            style: TextStyle(
                              fontSize: 18.fss,
                              color: Color.fromARGB(255, 149, 178, 218),
                              fontFamily: 'MontserratBold',
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Color.fromARGB(255, 28, 55, 92),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            );
          });
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isCollapsed ? 70 : 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isCollapsed
          ? InkWell(
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Icon(
                              Icons.account_box_outlined,
                              size: 30.ss,
                            )),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                ApiService.user.fullName.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'MontserratBold',
                                  fontSize: 14.fss,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${ApiService.user.role_Name}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'MontserratLight',
                                fontSize: 14.fss,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () async {
                            AlertDialogExit();
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context)
                    .push(Animations().createRoute(MyProfile()));
              },
            )
          : Column(
              children: [
                Expanded(
                  child: InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Icon(Icons.account_box_outlined)),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .push(Animations().createRoute(MyProfile()));
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () async {
                      AlertDialogExit();
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 18.ss,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
