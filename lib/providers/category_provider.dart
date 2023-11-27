import 'package:flutter/material.dart';
import 'package:pos/models/category_model.dart';
import 'package:pos/models/product_model.dart';
import 'package:pos/services/category_service.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _categoryList = [];
  List<ProductModel> _categoryProductList = [];

  List<CategoryModel> get categoryLists => _categoryList;
  List<ProductModel> get categoryProductList => _categoryProductList;

  set categoryLists(List<CategoryModel> categoryLists) {
    _categoryList = categoryLists;
    notifyListeners();
  }

  Future<void> getCategoryList() async {
    try {
      List<CategoryModel> categoryLists =
          await CategoryServices().getCategoryList();
      _categoryList = categoryLists;
      print(_categoryList);
    } catch (e) {
      print(e);
    }
  }

  set categoryProductList(List<ProductModel> categoryProductList) {
    _categoryProductList = categoryProductList;
    notifyListeners();
  }

  Future<void> getCategoryProductList(int id) async {
    _categoryProductList = [];
    try {
      List<ProductModel> categoryProductList =
          await CategoryServices().getCategoryProductList(id);
      _categoryProductList = categoryProductList;
    } catch (e) {
      print(e);
    }
  }

  int _selectCategory = 0;

  int get selectCategory => _selectCategory;

  set selectCategory(int index) {
    _selectCategory = index;
    notifyListeners();
  }
}
