class ScheduleClassesUsers {
  int? scheduleclass_id;
  int? user_id;
  DateTime? recordingTime;
  bool? isActive;
  ScheduleClassesUsers(
      {this.scheduleclass_id, this.user_id, this.recordingTime, this.isActive});

  static fromJson(Map<String, dynamic> jsonResponse) {
    if (jsonResponse == null) return null;
    return ScheduleClassesUsers(
        scheduleclass_id: jsonResponse['scheduleСlass_id'],
        user_id: jsonResponse['user_id'],
        recordingTime: DateTime.parse(jsonResponse['recordingTime']),
        isActive: jsonResponse['isActive']);
  }
}

class ScheduleClassesUsersFullInfo {
  int? scheduleClass_id;
  int? user_id;
  DateTime? recordingTime;
  String? location;
  DateTime? timeStart;
  DateTime? timeEnd;
  int? maxOfPeople;
  int? teacher_id;
  String? teacher_FullName;
  String? type_Name;
  String? details;
  String? image_Type;
  Duration? timeDuration;
  bool? isActiveUser;
  bool? isActive;
  bool? isDelete;
  ScheduleClassesUsersFullInfo(
      {this.scheduleClass_id,
      this.user_id,
      this.recordingTime,
      this.location,
      this.timeStart,
      this.timeEnd,
      this.maxOfPeople,
      this.teacher_id,
      this.teacher_FullName,
      this.type_Name,
      this.details,
      this.image_Type,
      this.isActiveUser,
      this.isDelete,
      this.timeDuration,
      this.isActive});

  static fromJson(Map<String, dynamic> jsonResponse) {
    if (jsonResponse == null) return null;
    return ScheduleClassesUsersFullInfo(
        scheduleClass_id: jsonResponse['scheduleСlass_id'],
        user_id: jsonResponse['user_id'],
        recordingTime: DateTime.parse(jsonResponse['recordingTime']),
        location: jsonResponse['location'],
        timeStart: DateTime.parse(jsonResponse['timeStart']),
        timeEnd: DateTime.parse(jsonResponse['timeEnd']),
        maxOfPeople: jsonResponse['maxOfPeople'],
        teacher_id: jsonResponse['teacher_id'],
        teacher_FullName: jsonResponse['teacher_FullName'],
        type_Name: jsonResponse['type_Name'],
        timeDuration: DateTime.parse(jsonResponse['timeEnd'])
            .difference(DateTime.parse(jsonResponse['timeStart'])),
        details: jsonResponse['details'],
        image_Type: jsonResponse['image_Type'],
        isActiveUser: jsonResponse['isActiveUser'],
        isActive: jsonResponse['isActive'],
        isDelete: jsonResponse['isDelete']);
  }
}
