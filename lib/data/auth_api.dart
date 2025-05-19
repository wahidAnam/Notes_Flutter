import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../core/constants.dart';

class AuthApi {

  //user login api
  static Future<UserModel?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      body: {
        "email": email,
        "password": password,
      },
    );

    final data = json.decode(response.body);
    if (response.statusCode == 200 && data['success'] == true) {
      return UserModel.fromJson(data['user']);
    }
    return null;
  }

  //user registration api
  static Future<bool> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse(registerUrl),
      body: {
        "name": name,
        "email": email,
        "password": password,
      },
    );

    final data = json.decode(response.body);
    return response.statusCode == 200 && data['success'] == true;
  }
}
