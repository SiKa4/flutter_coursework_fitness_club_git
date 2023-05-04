class Users {
  int? id_User;
  String? fullName;
  int? role_id;
  String? number;
  String? role_Name;
  Users({this.id_User, this.fullName, this.role_id, this.number, this.role_Name});

  static fromJson(Map<String, dynamic> jsonResponse) {
    // ignore: unnecessary_null_comparison
    if (jsonResponse == null) return null;
    return Users(
        id_User: jsonResponse['id_User'],
        fullName: jsonResponse['fullName'],
        role_id: jsonResponse['role_id'],
        number: jsonResponse['number'],
        role_Name: jsonResponse['role_Name']);
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

class Coach {
  int? id_User;
  String? fullName;
  int? role_id;
  String? number;
  String? description;
  String? image_URL;
  String? email;
  Coach(
      {this.id_User,
      this.fullName,
      this.role_id,
      this.number,
      this.description,
      this.image_URL,
      this.email});
  static fromJson(Map<String, dynamic> jsonResponse) {
    return Coach(
      id_User: jsonResponse['id_User'],
      fullName: jsonResponse['fullName'],
      role_id: jsonResponse['role_id'],
      number: jsonResponse['number'],
      description: jsonResponse['description'],
      image_URL: jsonResponse['image_URL'],
      email: jsonResponse['email'],
    );
  }
}
