import 'dart:convert';
import 'package:pos/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  String baseUrl = 'http://127.0.0.1:8000/api';

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
      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    // required String name,
    // required String username,
    String? nopol,
    String? password,
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

      print(user.token);
      print(data.runtimeType);
      return user;
    } else {
      throw Exception('Gagal Masuk!!');
    }
  }
}
