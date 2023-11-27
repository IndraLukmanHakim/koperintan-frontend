// import 'dart:ffi';

import 'package:pos/models/category_model.dart';
import 'package:pos/models/gallery_model.dart';

class ProductModel {
  int? id;
  String? name;
  int? price;
  int? point;
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
    this.point,
    this.tags,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.galleries,
    this.category,
  });

  // ProductModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   price = json['price'];
  //   point = json['point'];
  //   tags = json['tags'];
  //   description = json['description'];
  //   createdAt = DateTime.parse(json['created_at']);
  //   updatedAt = DateTime.parse(json['updated_at']);
  //   galleries = json['galleries']
  //       .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery))
  //       .toList();
  //   category = CategoryModel.fromJson(json['category']);
  // }
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    point = json['point'];
    tags = json['tags'];
    description = json['description'];
    createdAt =
        json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt =
        json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;

    // Check if 'galleries' is not null before mapping
    galleries = json['galleries'] != null
        ? List<GalleryModel>.from(json['galleries']
            .map<GalleryModel>((gallery) => GalleryModel.fromJson(gallery)))
        : null;

    // Check if 'category' is not null before creating the CategoryModel
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'point': point,
      'tags': tags,
      'description': description,
      'createdAt': createdAt.toString(),
      'updatedAt': updatedAt.toString(),
      'galleries': galleries!.map((gallery) => gallery.toJson()).toList(),
      'category': category!.toJson(),
    };
  }
}
