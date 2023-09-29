import 'package:dartz/dartz.dart';
import 'package:shopify/core/error/failure.dart';
import 'package:shopify/features/Cart/domain/entities/cart_entity.dart';
import 'package:shopify/features/Home/data/Models/products_model.dart';
import 'package:shopify/features/Home/domain/entities/product_entity.dart';


abstract class CartRepository{
  Future<Either<Failure,CartEntity> > getCartProducts();
}