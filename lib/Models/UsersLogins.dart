class Users {
  int? id_User;
  String? fullName;
  int? role_id;
  Users({this.id_User, this.fullName, this.role_id});

  static fromJson(Map<String, dynamic> jsonResponse) {
    // ignore: unnecessary_null_comparison
    if (jsonResponse == null) return null;
    return Users(
        id_User: jsonResponse['id_User'],
        fullName: jsonResponse['fullName'],
        role_id: jsonResponse['role_id']);
  }
}

class Logins {
  int? id_login;
  String? login;
  String? password;
  int? user_id;
  Logins({this.id_login, this.login, this.password, this.user_id});

  static fromJson(Map<String, dynamic> jsonResponse) {
    // ignore: unnecessary_null_comparison
    if (jsonResponse == null) return null;
    return Logins(
        id_login: jsonResponse['id_Login'],
        login: jsonResponse['login'],
        password: jsonResponse['password'],
        user_id: jsonResponse['user_id']);
  }
}
