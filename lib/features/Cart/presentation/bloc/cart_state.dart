import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:shopify/features/Cart/data/model/cart_response_model.dart';
import 'package:shopify/features/Cart/domain/entities/cart_entity.dart';

enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
}
class CartState extends Equatable{
   const CartState({
     this.status=HomeStatus.initial,
     this.error='',
    this.isError=false,
    this.isLoading=false,
    this.isSuccess=false,
     this.cartProductList,
     this.total=0


  });
    final HomeStatus status;
   final String error;
  final bool isSuccess;
  final bool isError;
  final bool isLoading;
  final int total;
  final List<CartModel>?  cartProductList;

  CartState copyWith({
    HomeStatus? status,
    String? error,
    bool? isSuccess,
    bool? isError,
    bool? isLoading,
    List<CartModel>?  cartProductList,
    int? total,
}){
    return CartState(
      total: total ?? this.total,
      status: status ?? this.status,
      error: error ?? this.error,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      cartProductList: cartProductList ?? this.cartProductList,
        isError: isError ?? this.isError
    );

}

  @override
  List<Object?> get props => [cartProductList,isSuccess,isError,isLoading,status,total];

}

