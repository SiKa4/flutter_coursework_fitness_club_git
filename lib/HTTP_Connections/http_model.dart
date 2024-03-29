import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:signalr_netcore/signalr_client.dart';

import '../Models/ScheduleСlassesUsers.dart';
import '../Models/SheduleClassesAndTypes.dart';
import '../Models/ShopClasses.dart';
import '../Models/UsersLogins.dart';
import 'dart:io';

class ApiService extends HttpOverrides {
  static var user;
  static var login;
  var baseUrl = 'https://217.66.25.160:8443/api';
  var headers = {
    'ApiKey': 'gc2tPOwfXPOFHX5SYOzZFFmN9DXiH40xzN2o3h0MQzJ5y',
    'Content-Type': 'application/json'
  };

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  Future<Users?> getUserByLogPass(String login, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    var body = {'Login': '$login', 'Password': '$password'};
    var client = new http.Client();
    final response = await client.post(Uri.parse('$baseUrl/logins/logPass'),
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
    final response =
        await http.get(Uri.parse('$baseUrl/users/$id_User'), headers: headers);
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
    final response =
        await http.get(Uri.parse('$baseUrl/logins/$login'), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> getSendCodeEmailAdress(String login) async {
    final response = await http.get(Uri.parse('$baseUrl/emailSend/$login'),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonResponce = json.decode(response.body);
      var code = jsonResponce['numberCode'];
      return code;
    }
    return null;
  }

  Future<bool> setNewUserByLoginAndPassword(
      String login, String password, String fullName, String Number) async {
    var body = {
      'id_User': 1,
      'FullName': '$fullName',
      'Role_id': 3,
      'Number': '$Number'
    };
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

  Future<ScheduleClassesUsersFullInfo?> setScheduleClassAndUser(
      int id_ScheduleClass, int id_User) async {
    var body = {
      'scheduleСlass_id': id_ScheduleClass,
      'user_id': id_User,
      'isActive': true
    };
    final response = await http.post(Uri.parse('$baseUrl/scheduleСlassesUsers'),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return ScheduleClassesUsersFullInfo.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<Users?> UpdateUser(Users user) async {
    await Future.delayed(const Duration(seconds: 1));
    var body = {
      'id_User': user.id_User,
      'FullName': user.fullName,
      'Role_id': user.role_id,
      'Number': '${user.number}'
    };
    final response = await http.put(Uri.parse('$baseUrl/users/${user.id_User}'),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return await Users.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<List<SheduleClassesAndTypes?>?> GetAllShedulesAndFullInfo() async {
    final response =
        await http.get(Uri.parse('$baseUrl/shedules'), headers: headers);
    if (response.statusCode == 200) {
      List<SheduleClassesAndTypes> posts = List<SheduleClassesAndTypes>.from(
          json
              .decode(response.body)
              .map((model) => SheduleClassesAndTypes.fromJson(model)));
      return posts;
    } else {
      return null;
    }
  }

  Future<ScheduleClassesUsersFullInfo?> PutSchedulesUsers(
      ScheduleClassesUsersFullInfo scheduleClassesUsersFullInfo) async {
    var body = {
      'scheduleСlass_id': scheduleClassesUsersFullInfo.scheduleClass_id,
      'user_id': scheduleClassesUsersFullInfo.user_id,
      'isActive': scheduleClassesUsersFullInfo.isActiveUser
    };
    final response = await http.put(Uri.parse('$baseUrl/scheduleСlassesUsers'),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return await ScheduleClassesUsersFullInfo.fromJson(
          json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<List<DateInApi?>?> GetAllDateWeek() async {
    final response =
        await http.get(Uri.parse('$baseUrl/dateAPI'), headers: headers);
    if (response.statusCode == 200) {
      List<DateInApi> date = List<DateInApi>.from(
          json.decode(response.body).map((model) => DateInApi.fromJson(model)));
      return date;
    } else {
      return null;
    }
  }

  Future<List<Coach?>?> GetAllCoachAndFullInfo() async {
    final response =
        await http.get(Uri.parse('$baseUrl/users/coach'), headers: headers);
    if (response.statusCode == 200) {
      List<Coach> coachList = List<Coach>.from(
          json.decode(response.body).map((model) => Coach.fromJson(model)));
      return coachList;
    } else {
      return null;
    }
  }

  Future<List<Item?>?> GetAllItem() async {
    final response =
        await http.get(Uri.parse('$baseUrl/shopItem'), headers: headers);
    if (response.statusCode == 200) {
      List<Item> itemList = List<Item>.from(
          json.decode(response.body).map((model) => Item.fromJson(model)));
      return itemList;
    } else {
      return null;
    }
  }

  Future<List<ScheduleClassesUsersFullInfo?>?> GetAllUserSchedulesAndFullInfo(
      int idUser) async {
    final response = await http.get(
        Uri.parse('$baseUrl/scheduleСlassesUsers/$idUser'),
        headers: headers);
    if (response.statusCode == 200) {
      List<ScheduleClassesUsersFullInfo> scheduleClassesUsersFullInfo =
          List<ScheduleClassesUsersFullInfo>.from(json
              .decode(response.body)
              .map((model) => ScheduleClassesUsersFullInfo.fromJson(model)));
      return scheduleClassesUsersFullInfo;
    } else {
      return null;
    }
  }

  Future<List<BasketFullInfo?>?> GetAllBasketFullInfoByIdUser(
      int idUser) async {
    final response = await http.get(
        Uri.parse('$baseUrl/shopBasket/userIdFullInfo/${idUser}'),
        headers: headers);
    if (response.statusCode == 200) {
      List<BasketFullInfo> basketFullInfo = List<BasketFullInfo>.from(json
          .decode(response.body)
          .map((model) => BasketFullInfo.fromJson(model)));
      return basketFullInfo;
    } else {
      return null;
    }
  }

  Future<BasketFullInfo?> PostBasket(int idUser, idItem, itemCount) async {
    var body = {
      'shopItem_id': idItem,
      'user_id': idUser,
      'shopItemCount': itemCount
    };
    final response = await http.post(Uri.parse('$baseUrl/shopBasket'),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return await BasketFullInfo.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> PutBasket(BasketFullInfo basketFullInfo) async {
    var body = {
      'id_ShopBasket': basketFullInfo.id_ShopBasket,
      'shopItemCount': basketFullInfo.shopItemCount,
    };
    final response = await http.put(Uri.parse('$baseUrl/shopBasket'),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<ShopOrderFullInfo?> PostShopOrder(List<BasketFullInfo?> basket) async {
    var body = [];
    for (var i in basket) {
      body.add({"idShopBasket": i!.id_ShopBasket});
    }
    final response = await http.post(
        Uri.parse('$baseUrl/shopOrders/${user.id_User}'),
        headers: headers,
        body: json.encode(body));
    if (response.statusCode == 200) {
      return await ShopOrderFullInfo.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<List<ShopOrderFullInfo?>?> GetShopOrderByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/shopOrders/${userId}'),
        headers: headers);
    if (response.statusCode == 200) {
      List<ShopOrderFullInfo> shopOrders = List<ShopOrderFullInfo>.from(json
          .decode(response.body)
          .map((model) => ShopOrderFullInfo.fromJson(model)));
      return shopOrders;
    } else {
      return null;
    }
  }

  static var hubConnection;
  static Future<void> GetNewShedulesAndFullInfo() async {
    hubConnection = HubConnectionBuilder()
        .withUrl("https://217.66.25.160:8443/signalRHubShedules")
        .build();
    hubConnection.start();
  }

  static var hubConnectionOrderStatus;
  static Future<void> GetNewConnectionOrderStatus() async {
    hubConnectionOrderStatus = HubConnectionBuilder()
        .withUrl("https://217.66.25.160:8443/signalRHubOrderStatus")
        .build();
    hubConnectionOrderStatus.start();
  }
}
