import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../Models/UsersLogins.dart';

class ApiService {
  var baseUrl = 'http://217.66.25.160:5001/api';
  var headers = {
    'ApiKey': 'gc2tPOwfXPOFHX5SYOzZFFmN9DXiH40xzN2o3h0MQzJ5y',
    'Content-Type': 'application/json'
  };

  Future<Users?> getUserLogPass(String login, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    var body = {'login': '$login', 'password': '$password'};
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
}
