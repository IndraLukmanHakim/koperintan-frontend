import 'dart:convert';

import 'package:pos/models/product_model.dart';
//import material.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistProvider with ChangeNotifier {
  late SharedPreferences _prefs; // Declare SharedPreferences variable

  List<ProductModel> _wishlist = [];

  List<ProductModel> get wishlist => _wishlist;

  WishlistProvider() {
    loadWishlist(); // Load wishlist from SharedPreferences on initialization
  }

  set wishlist(List<ProductModel> wishlist) {
    _wishlist = wishlist;
    _saveWishlist(); // Save wishlist to SharedPreferences when it changes
    notifyListeners();
  }

  setProduct(ProductModel product) {
    if (!isWishlist(product)) {
      _wishlist.add(product);
      print('hai alek');
      print(product.toJson());
    } else {
      _wishlist.removeWhere((element) => element.id == product.id);
    }
    _saveWishlist(); // Save wishlist to SharedPreferences after modification
    notifyListeners();
  }

  isWishlist(ProductModel product) {
    return _wishlist.indexWhere((element) => element.id == product.id) != -1;
  }

  // Load wishlist from SharedPreferences
  Future<void> loadWishlist() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final String? wishlistJson = _prefs.getString('wishlist');

      if (wishlistJson != null) {
        Iterable decoded = jsonDecode(wishlistJson);
        _wishlist = List<ProductModel>.from(
          decoded.map(
            (item) => ProductModel.fromJson(item as Map<String, dynamic>),
          ),
        );
        notifyListeners();
      }
    } catch (error) {
      print('Error loading wishlist: $error');
    }
  }

  // Save wishlist to SharedPreferences
  Future<void> _saveWishlist() async {
    final String wishlistJson = jsonEncode(_wishlist);
    await _prefs.setString('wishlist', wishlistJson);
    print(_prefs.getString('wishlist'));
  }
}
