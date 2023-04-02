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
      this.image_Type});

  static fromJson(Map<String, dynamic> jsonResponse) {
    // ignore: unnecessary_null_comparison
    if (jsonResponse == null) return null;
    return SheduleClassesAndTypes(
        id_ScheduleClass: jsonResponse['id_ScheduleClass'],
        location: jsonResponse['location'],
        timeStart: DateTime.parse(jsonResponse['timeStart']),
        timeEnd:  DateTime.parse(jsonResponse['timeEnd']),
        maxOfPeople: jsonResponse['maxOfPeople'],
        scheduleClassType_id: jsonResponse['scheduleClassType_id'],
        teacher_id: jsonResponse['teacher_id'],
        teacher_FullName: jsonResponse['teacher_FullName'],
        type_Name: jsonResponse['type_Name'],
        details: jsonResponse['details'],
        image_Type: jsonResponse['image_Type']);
  }

}
