import 'dart:convert';
import 'package:pos/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:pos/models/status_model.dart';

import '../models/cart_model.dart';
import '../util/app_const.dart';

class TransactionService {
  // String baseUrl = 'http://127.0.0.1:8000/api';
  // String baseUrl = 'http://192.168.0.100:8000/api';
  String baseUrl = App_constants.BASE_URL;

  Future<bool> checkout(String address, String token, List<CartModel> carts,
      int totalPrice, int totalPoint) async {
    var url = '$baseUrl/checkout';

    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var body = jsonEncode({
      'address': address, // AMBIL DATA DARI CONTORLLER FORM DO CHECKOUT PAGE
      'items': carts
          .map((cart) => {
                'id': cart.product!.id,
                'quantity': cart.quantity,
              })
          .toList(),
      'status': 'PENDING',
      'total_price': totalPrice,
      'shipping_price': 0,
      'total_point': totalPoint,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(
          'Gagal Melakukan Checkout!, Harap mengisi alamat lengkap!!!');
    }
  }

  Future<List<StatusModel>> getStatus(String token) async {
    var url = '$baseUrl/transactions';

    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(response.statusCode);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<StatusModel> status = [];

      for (var item in data) {
        status.add(StatusModel.fromJson(item));
      }
      // print(jsonDecode(response.body)['data']['data']);
      // print(data);
      return status;
    } else {
      throw Exception('Gagal Mendapatkan Status!');
    }
  }
}
