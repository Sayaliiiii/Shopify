import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:shopify/core/error/exception.dart';
import 'package:shopify/core/error/failure.dart';
import 'package:shopify/features/Cart/data/data_source/cart_remote_data_source.dart';
import 'package:shopify/features/Cart/domain/entities/cart_entity.dart';
import 'package:shopify/features/Cart/domain/repositories/cart_repository.dart';

class CartService implements CartRepository{
  final CartRemoteDataSource cartRemoteDataSource;
  CartService({required this.cartRemoteDataSource});

  @override
  Future<Either<Failure, CartEntity>> getCartProducts()  async {
    try{
      final result = await  cartRemoteDataSource.getProductsInCart();
    // final response=result.map((e) => e.toEntity()).toList();
      // final response=result.
    return Right(result.toEntity());

    }on ServerException {
    return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
    return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }


}