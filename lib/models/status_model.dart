import 'package:intl/intl.dart';

class StatusModel {
  int? id;
  // String? name;
  String? address;
  int? totalPrice;
  String? status;
  int? point;
  String? createdAt;
  String? updatedAt;

  StatusModel(
    this.id,
    // this.name,
    this.address,
    this.totalPrice,
    this.status,
    this.point,
    this.createdAt,
    this.updatedAt,
  );

  StatusModel.fromJson(Map<String, dynamic> json) {
    id = json['users_id'];
    // name = json['name'];
    address = json['address'];

    totalPrice = json['total_price'];
    status = json['status'];

    point = json['total_point'];
    createdAt = DateFormat('yyyy-MM-dd | kk:mm')
        .format(DateTime.parse(json['created_at']).toLocal());
    updatedAt = DateFormat('yyyy-MM-dd | kk:mm')
        .format(DateTime.parse(json['updated_at']).toLocal());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // 'name': name,
      'address': address,
      'total_price': totalPrice,
      'status': status,
      'point': point,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
    };
  }
}
