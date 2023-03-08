import 'package:flutter/material.dart';
import 'package:pos/models/cart_model.dart';
import 'package:pos/models/product_model.dart';
import 'package:pos/pages/widgets/product_card.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _cartList = [];
  List<CartModel> get cartList => _cartList;

  set carts(List<CartModel> carts) {
    _cartList = carts;
    notifyListeners();
  }

  addCart(ProductModel product) {
    if (productExist(product)) {
      int index =
          _cartList.indexWhere((element) => element.product!.id == product.id);
      _cartList[index].quantity++;
    } else {
      _cartList.add(
        CartModel(
          id: _cartList.length,
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  removeCart(int id) {
    _cartList.removeAt(id);
    notifyListeners();
  }

  addQuantity(int id) {
    _cartList[id].quantity++;
    notifyListeners();
  }

  reduceQuantity(int id) {
    _cartList[id].quantity--;
    if (_cartList[id].quantity == 0) {
      _cartList.removeAt(id);
    }
    notifyListeners();
  }

  totalItems() {
    int total = 0;
    for (var item in _cartList) {
      total += item.quantity!;
    }
    return total;
  }

  totalPrice() {
    double total = 0;
    for (var item in _cartList) {
      total += item.product!.price! * item.quantity!;
    }
    return total;
  }

  productExist(ProductModel product) {
    if (_cartList.indexWhere((element) => element.product!.id == product.id) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }
}
