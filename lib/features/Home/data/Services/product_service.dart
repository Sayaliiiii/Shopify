import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:shopify/core/error/exception.dart';
import 'package:shopify/core/error/failure.dart';
import 'package:shopify/features/Home/data/DataSource/product_remote_data_source.dart';
import 'package:shopify/features/Home/domain/Repositories/product_repository.dart';
import 'package:shopify/features/Home/domain/entities/cateogry_entity.dart';
import 'package:shopify/features/Home/domain/entities/product_entity.dart';
class ProductService implements ProductRepository{
  final ProductRemoteDataSource productRemoteDataSource;
  ProductService({required this.productRemoteDataSource});
  @override
  Future<Either<Failure,List<ProductEntity>> > getAllProducts() async {
    try{
      final result = await  productRemoteDataSource.getAllProducts();
      final response=result.map((e) => e.toEntity()).toList();
      return Right(response);

    }on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getCateogryProducts(String cateogry) async{
    try{
      final result = await  productRemoteDataSource.getCateogryProducts(cateogry);
      final response=result.map((e) => e.toEntity()).toList();
      return Right(response);

    }on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

}