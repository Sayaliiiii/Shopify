import 'package:dartz/dartz.dart';
import 'package:shopify/core/error/failure.dart';
import 'package:shopify/features/Home/data/Models/products_model.dart';
import 'package:shopify/features/Home/domain/entities/cateogry_entity.dart';
import 'package:shopify/features/Home/domain/entities/product_entity.dart';


abstract class ProductRepository{
  Future<Either<Failure,List<ProductEntity>> > getAllProducts();

  Future<Either<Failure,List<ProductEntity>>> getCateogryProducts(String cateogry);
}