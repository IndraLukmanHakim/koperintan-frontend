// import material.dart
import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

import '../util/app_const.dart';

class CategoryServices {
  // String baseUrl = 'http://127.0.0.1:8000/api';
  String baseUrl = App_constants.BASE_URL;
  // String baseUrl = 'http://10.162.1.11:8000/api';

  Future<List<CategoryModel>> getCategoryList() async {
    var url = '$baseUrl/categories?show_product=1';

    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(jsonDecode(response.body)['data']['data']);

    print('response category = ${response.statusCode} ');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['data'];
      List<CategoryModel> categoryLists = [];

      for (var item in data) {
        categoryLists.add(CategoryModel.fromJson(item));
      }
      // print(categoryLists);
      return categoryLists;
    } else {
      throw Exception('Gagal Get Categories!');
    }
  }

  Future<List<ProductModel>> getCategoryProductList(int id) async {
    var url = '$baseUrl/categories/?id=$id';

    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(Uri.parse(url), headers: headers);

    print(jsonDecode(response.body)['data']['products']);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['products'];
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
