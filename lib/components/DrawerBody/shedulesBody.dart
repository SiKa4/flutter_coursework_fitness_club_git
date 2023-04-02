import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
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
     WidgetsBinding.instance.addPostFrameCallback((_){
    _asyncMethodGet();
  });
  }

  _asyncMethodGet() async {
     sheduleClassesAndTypes = (await ApiService().GetAllShedulesAndFullInfo()) as List<SheduleClassesAndTypes>?;
    setState((){
    });
    isLoading = false;  
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [Column(
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
                      color: index == _selectedDayIndex ? Colors.grey[800] : null,
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
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Text(sheduleClassesAndTypes?[index].teacher_FullName.toString() ?? "123")
                  );
                },
              ),
            ),
          ],
        ),isLoading
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
