import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? userData;

  static Future saveUserData(UserModel model, String tkn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('token', tkn);
    sharedPreferences.setString('user-data', jsonEncode(model.toJson()));

    token = tkn;
    userData = model;
  }

  static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? tkn = sharedPreferences.getString('token');

    if (tkn != null) {
      token = tkn;
    }

    String? uData = sharedPreferences.getString('user-data');

    if (uData != null) {
      userData = UserModel.fromJson(jsonDecode(uData));
    }
  }

  static Future<bool> isUserLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? tkn = sharedPreferences.getString('token');
    return tkn != null;
  }
}