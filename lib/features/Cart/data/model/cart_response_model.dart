// To parse this JSON data, do
//
//     final cartResponseModel = cartResponseModelFromJson(jsonString);


// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:shopify/features/Cart/domain/entities/cart_entity.dart';

// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  int id;
  String title;
  double price;
  int quantity;
  String image;

  CartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    quantity: json["quantity"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "quantity": quantity,
    "image": image,
  };
}

List<CartResponseModel> cartResponseModelFromJson(String str) => List<CartResponseModel>.from(json.decode(str).map((x) => CartResponseModel.fromJson(x)));

String cartResponseModelToJson(List<CartResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartResponseModel {
  int id;
  int userId;
  DateTime date;
  List<Product> products;
  int v;

  CartResponseModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.v,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) => CartResponseModel(
    id: json["id"],
    userId: json["userId"],
    date: DateTime.parse(json["date"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "date": date.toIso8601String(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "__v": v,
  };

  CartEntity toEntity() => CartEntity(id: id, userId: userId, date: date, v: v, products: products);
}

class Product {
  int productId;
  int quantity;

  Product({
    required this.productId,
    required this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
  };
}
