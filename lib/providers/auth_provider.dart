import 'package:flutter/material.dart';
import 'package:pos/models/user_model.dart';
import 'package:pos/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    String? name,
    // // String? username,
    String? nopol,
    String? phone,
    String? password,

    // required String name,
    // // required String username,
    // required String nopol,
    // required String password,
  }) async {
    try {
      UserModel user = await AuthServices().register(
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
    // // required String username,
    // required String nopol,
    // required String password,
  }) async {
    try {
      UserModel user = await AuthServices().login(
        // there is two type to get the value:
        // 1. can't be null, '' will use as default
        // name: name ?? '',
        // 2. can't be null, required var value in the first place
        // username: username ?? '',
        nopol: nopol,
        password: password,
      );

      _user = user;
      // print(_user);
      // print(_user.runtimeType);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
