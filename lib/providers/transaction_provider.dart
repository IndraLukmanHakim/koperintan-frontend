import "package:flutter/material.dart";
import 'package:pos/models/cart_model.dart';
import 'package:pos/services/transaction_service.dart';

import '../models/status_model.dart';

class TransactionProvider with ChangeNotifier {
  List<StatusModel> _status = [];
  List<StatusModel> get status => _status;

  Future<bool> checkout(address, String token, List<CartModel> carts,
      int totalPrice, int totalPoint) async {
    try {
      if (await TransactionService()
          .checkout(address, token, carts, totalPrice, totalPoint)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> getStatus(token) async {
    try {
      List<StatusModel> status = await TransactionService().getStatus(token);
      _status = status;
    } catch (e) {
      print(e);
    }
  }

  totalstatus() {
    int count = 0;
    for (var i = 0; i < _status.length; i++) {
      if (_status[i].status != "Selesai") {
        count++;
      }
    }
    return count;
  }
}
