import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pos/models/user_model.dart';
import 'package:pos/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;
  AuthServices? authServices;
  late SharedPreferences sharedPreferences;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> updateuser(token) async {
    try {
      // UserModel user = await AuthServices().updateuser(token);
      sharedPreferences = await SharedPreferences.getInstance();
      UserModel user = await AuthServices(sharedPreferences).updateuser(token);

      _user = user;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> register({
    String? name,
    // // String? username,
    String? nopol,
    String? phone,
    String? password,
  }) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      UserModel user = await AuthServices(sharedPreferences).register(
        // there is two type to get the value:
        // 1. can't be null, '' will use as default
        name: name,
        phone: phone,
        // 2. can't be null, required var value in the first place
        // username: username ?? '',
        nopol: nopol,
        password: password,
      );

      _user = user;
      print(_user);
      print(_user.runtimeType);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    // String? name,
    // // String? username,
    String? nopol,
    String? password,
  }) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      print(nopol);
      print(password);
      UserModel user = await AuthServices(sharedPreferences).login(
        nopol: nopol,
        password: password,
      );
      _user = user;
      AuthServices(sharedPreferences).saveuserToken(user.token!);
      // print(_user);
      // print(_user.runtimeType);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout(String token) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      await AuthServices(sharedPreferences).logout(token);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> changePassword({
    required String password,
    required String new_password,
  }) async {
    try {
      // Access the token from the AuthProvider
      String token = await getuserToken();

      // Call AuthServices to change the password
      await authServices!.changePassword(
        token: token,
        password: password,
        new_password: new_password,
      );

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> isLoggedin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    print('isLoggedin');
    print(AuthServices(sharedPreferences).isLoggedin());
    return AuthServices(sharedPreferences).isLoggedin();
  }

  //get user token
  Future<String> getuserToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return AuthServices(sharedPreferences).getToken();
  }

  Future<bool> editProfile({
    String? name,
    String? nopol,
    String? phone,
  }) async {
    try {
      // Access the token from the AuthProvider
      String token = await getuserToken();

      // Call AuthServices to edit the profile
      await authServices!.editProfile(
        token: token,
        name: name,
        nopol: nopol,
        phone: phone,
      );

      // Fetch and update the user information
      await updateuser(token);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
