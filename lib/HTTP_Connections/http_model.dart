import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../Models/UsersLogins.dart';

class ApiService {
  static var user;
  static var login;
  var baseUrl = 'http://217.66.25.160:5001/api';
  var headers = {
    'ApiKey': 'gc2tPOwfXPOFHX5SYOzZFFmN9DXiH40xzN2o3h0MQzJ5y',
    'Content-Type': 'application/json'
  };

  Future<Users?> getUserByLogPass(String login, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    var body = {'Login': '$login', 'Password': '$password'};
    final response = await http.post(Uri.parse('$baseUrl/logins/logPass'),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var Login = Logins.fromJson(jsonResponse);
      final responseUser = await http
          .get(Uri.parse('$baseUrl/users/${Login.user_id}'), headers: headers);
      return await Users.fromJson(json.decode(responseUser.body));
    } else {
      return null;
    }
  }

  Future<Users?> getUserById(int id_User) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id_User'),
        headers: headers);
    if (response.statusCode == 200) {
      return Users.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<Logins?> getLoginsByIdUser(int id_User) async {
    final response = await http.get(Uri.parse('$baseUrl/logins/logId/$id_User'),
        headers: headers);
    if (response.statusCode == 200) {
      return Logins.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> isExistsUserByLog(String login) async {
    final response = await http.get(Uri.parse('$baseUrl/logins/logPass/$login'),
        headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setNewUserByLoginAndPassword(
      String login, String password) async {
    var body = {'id_User': 1, 'FullName': '', 'Role_id': 3, 'Number': ''};
    final response = await http.post(Uri.parse('$baseUrl/users'),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var user = Users.fromJson(jsonResponse);
      body = {
        'id_Login': '1',
        'Login': '$login',
        'Password': '$password',
        'User_id': '${user.id_User}'
      };
      final responseUser = await http.post(Uri.parse('$baseUrl/logins'),
          headers: headers, body: json.encode(body));
      if (responseUser.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<Users?> UpdateUser(Users user) async {
    await Future.delayed(const Duration(seconds: 1));
    var body = {'id_User': user.id_User, 'FullName': user.fullName, 'Role_id': user.role_id, 'Number': '${user.number}'};
    final response = await http.put(Uri.parse('$baseUrl/users/${user.id_User}'),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return await Users.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
