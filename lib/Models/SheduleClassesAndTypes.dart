class SheduleClassesAndTypes {
  int? id_ScheduleClass;
  String? location;
  DateTime? timeStart;
  DateTime? timeEnd;
  int? maxOfPeople;
  int? scheduleClassType_id;
  int? teacher_id;
  String? teacher_FullName;
  String? type_Name;
  String? details;
  String? image_Type;
  Duration? timeDuration;
  bool? isActive;
  bool? isDelete;
  SheduleClassesAndTypes(
      {this.id_ScheduleClass,
      this.location,
      this.timeStart,
      this.timeEnd,
      this.maxOfPeople,
      this.scheduleClassType_id,
      this.teacher_id,
      this.teacher_FullName,
      this.type_Name,
      this.details,
      this.image_Type,
      this.timeDuration,
      this.isActive,
      this.isDelete});

  static fromJson(Map<String, dynamic> jsonResponse) {
    // ignore: unnecessary_null_comparison
    if (jsonResponse == null) return null;
    return SheduleClassesAndTypes(
        id_ScheduleClass: jsonResponse['id_ScheduleСlass'],
        location: jsonResponse['location'],
        timeStart: DateTime.parse(jsonResponse['timeStart']),
        timeEnd: DateTime.parse(jsonResponse['timeEnd']),
        maxOfPeople: jsonResponse['maxOfPeople'],
        scheduleClassType_id: jsonResponse['scheduleClassType_id'],
        teacher_id: jsonResponse['teacher_id'],
        timeDuration: DateTime.parse(jsonResponse['timeEnd'])
            .difference(DateTime.parse(jsonResponse['timeStart'])),
        teacher_FullName: jsonResponse['teacher_FullName'],
        type_Name: jsonResponse['type_Name'],
        details: jsonResponse['details'],
        image_Type: jsonResponse['image_Type'],
        isActive: jsonResponse['isActive'],
        isDelete: jsonResponse['isDelete']);
  }
}

class DateInApi {
  DateTime? date;
  DateInApi({this.date});

  static fromJson(Map<String, dynamic> jsonResponse) {
    // ignore: unnecessary_null_comparison
    if (jsonResponse == null) return null;
    return DateInApi(date: DateTime.parse(jsonResponse['date']));
  }
}
