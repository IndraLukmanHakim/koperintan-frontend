import "package:flutter/material.dart";
import 'package:pos/models/cart_model.dart';
import 'package:pos/services/transaciton_service.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> checkout(
      address, String token, List<CartModel> carts, int totalPrice) async {
    try {
      if (await TransactionService()
          .checkout(address, token, carts, totalPrice)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
