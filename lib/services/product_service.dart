import 'dart:convert';
import 'package:pos/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<ProductModel>> getProducts() async {
    var url = '$baseUrl/products';

    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(jsonDecode(response.body)['data']['data']);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<ProductModel> products = [];

      for (var item in data) {
        products.add(ProductModel.fromJson(item));
      }
      print(response.statusCode);
      return products;
    } else {
      throw Exception('Gagal Get Products!');
    }
  }
}
