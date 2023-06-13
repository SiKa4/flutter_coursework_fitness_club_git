import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_coursework_fitness_club/HTTP_Connections/http_model.dart';

class TeacherRaitingPage extends StatefulWidget {
  const TeacherRaitingPage({super.key});

  @override
  State<TeacherRaitingPage> createState() => _TeacherRaitingPageState();
}

class _TeacherRaitingPageState extends State<TeacherRaitingPage> {
  @override
  void initState() {
    //asyncInitState();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethodGet();
    });
  }

  var listCoach;
  _asyncMethodGet() async {
    listCoach = await ApiService().GetAllCoachAndFullInfo();
  }

  Widget build(BuildContext context) {
    return const Center();
  }
}
