import 'package:pos/models/product_model.dart';

class CartModel {
  late int id;
  late int quantity;
  ProductModel? product;

  CartModel({required this.id, required this.quantity, this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null
        ? new ProductModel.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'product': product!.toJson(),
    };
  }

  int getTotalPrice() {
    return product!.price! * quantity;
  }
}
