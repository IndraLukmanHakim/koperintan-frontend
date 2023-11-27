import 'dart:convert';

import 'package:pos/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pos/util/app_const.dart';

class AuthServices {
  final SharedPreferences sharedPreferences;
  // String baseUrl = 'http://127.0.0.1:8000/api';
  // String baseUrl = 'http://192.168.0.100:8000/api';
  final baseUrl = App_constants.BASE_URL;

  AuthServices(this.sharedPreferences);

  // AuthServices(this.sharedPreferences);

  Future<UserModel> updateuser(String token) async {
    var url = '$baseUrl/user';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      UserModel user = UserModel.fromJson(data);
      user.token = token;

      print(user.token);
      print(data.runtimeType);
      // simpan user ke local storage

      String userToken = user.token!;
      saveuserToken(userToken);

      return user;
    } else {
      throw Exception('Gagal Get User!');
    }
  }

  Future<UserModel> register({
    String? name,
    // required String username,
    String? nopol,
    String? phone,
    String? password,
  }) async {
    var url = '$baseUrl/register';

    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      // 'username': username,
      'nopol': nopol,
      'phone': phone,
      'password': password,
    });

    print(
      body,
    );

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      UserModel user = UserModel.fromJson(data['user']);

      user.token = 'Bearer ' + data['access_token'];

      print(user.runtimeType);
      print(data.runtimeType);

      // simpan user ke local storage

      String userToken = user.token!;
      saveuserToken(userToken);

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    // required String name,
    // required String username,
    required nopol,
    required password,
  }) async {
    var url = '$baseUrl/login';

    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      // 'name': name,
      // 'username': username,
      'nopol': nopol,
      'password': password,
    });

    print(
      body,
    );

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    print(response.body.runtimeType);
    print(response);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      UserModel user = UserModel.fromJson(data['user']);

      user.token = 'Bearer ' + data['access_token'];

      // sharedPreferences?.setStringList('list', Splist);
      // sharedPreferences?.setString('token', user.token!);

      print(user.token);
      print(data.runtimeType);
      // simpan user ke local storage

      String userToken = user.token!;
      saveuserToken(userToken);

      return user;
    } else {
      throw Exception('Gagal Masuk sayang!!');
    }
  }

  Future<bool> logout(String token) async {
    var url = '$baseUrl/logout';
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.post(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      removeToken();
      // removeuser();
      return true;
    } else {
      throw Exception('Gagal Logout');
    }
  }

  Future<void> editProfile({
    required String token,
    String? name,
    String? nopol,
    String? phone,
  }) async {
    try {
      var url = '$baseUrl/user';

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      // Include only non-null values in the request body
      var body = jsonEncode({
        if (name != null) 'name': name,
        if (nopol != null) 'nopol': nopol,
        if (phone != null) 'phone': phone,
      });

      var response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Profile updated successfully');
        // You can handle the response data if needed
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (e) {
      print(e);
      throw Exception('Exception during profile update');
    }
  }

  Future<void> saveuserToken(String token) async {
    // token = UserModel().token!;

    try {
      print(token);
      await sharedPreferences?.setString('token', token);
      bool keyExist = sharedPreferences?.containsKey('token') ?? false;
      print(keyExist);
      print("berhasil save token");
    } catch (e) {
      print('Gagal save token');
      throw Exception(e.toString());
    }
  }

  Future<void> changePassword({
    required String token,
    required String password,
    required String new_password,
  }) async {
    try {
      var url = '$baseUrl/changepassword';

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var body = jsonEncode({
        'password': password,
        'new_password': new_password,
      });

      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Password berhasil di ubah');
        // You can handle the response data if needed
      } else {
        throw Exception('Gagal ganti password');
      }
    } catch (e) {
      print(e);
      throw Exception('Exception during password change');
    }
  }

  String getToken() {
    return sharedPreferences.getString('token') ?? '';
  }

  bool isLoggedin() {
    return sharedPreferences.containsKey('token');
  }

  Future<void> removeToken() async {
    try {
      // sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove('token');
    } catch (e) {
      print(e.toString());
    }
  }

  // get and set user and pw

  // delete user

  Future<void> removeuser() async {
    try {
      // sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences?.remove('list');
    } catch (e) {
      print(e.toString());
    }
  }

//   }
}
