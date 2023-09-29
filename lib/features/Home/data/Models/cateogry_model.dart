// To parse this JSON data, do
//
//     final cateogryModel = cateogryModelFromJson(jsonString);

import 'dart:convert';

import 'package:shopify/features/Home/domain/entities/cateogry_entity.dart';
import 'package:shopify/features/Home/domain/entities/product_entity.dart';

List<CateogryModel> cateogryModelFromJson(String str) => List<CateogryModel>.from(json.decode(str).map((x) => CateogryModel.fromJson(x)));

String cateogryModelToJson(List<CateogryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CateogryModel {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating;

  CateogryModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory CateogryModel.fromJson(Map<String, dynamic> json) => CateogryModel(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: json["category"],
    image: json["image"],
    rating: Rating.fromJson(json["rating"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "description": description,
    "category": category,
    "image": image,
    "rating": rating.toJson(),
  };
  ProductEntity toEntity() => ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rate: rating.rate,
      count: rating.count);
}

class Rating {
  double rate;
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "count": count,
  };
}
