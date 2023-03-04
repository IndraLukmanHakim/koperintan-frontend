// import 'dart:ffi';

import 'package:pos/models/category_model.dart';
import 'package:pos/models/gallery_model.dart';

class ProductModel {
  int? id;
  String? name;
  int? price;
  String? description;
  String? tags;
  CategoryModel? category;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<GalleryModel>? galleries;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.tags,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.galleries,
    this.category,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    tags = json['tags'];
    description = json['description'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    galleries = json['galleries']
        .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery))
        .toList();
    category = CategoryModel.fromJson(json['category']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'tags': tags,
      'descriptions': description,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'galleries': galleries!.map((gallery) => gallery.toJson()).toList(),
      'category': category!.toJson(),
    };
  }
}
