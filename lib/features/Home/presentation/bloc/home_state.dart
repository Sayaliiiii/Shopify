// abstract class HomeState{
//
// }
//
// class HomeInitial extends HomeState{}
// class HomeLoading extends HomeState{}
// class HomeLoaded extends HomeState{
//   final List<ProductEntity>? productsList;
//   HomeLoaded()
// }

import 'package:equatable/equatable.dart';
import 'package:shopify/features/Home/domain/entities/product_entity.dart';
enum HomeStatus {
  initial,
  loading,
  loaded,
  error,
  increment,decrement
}
 class HomeState extends Equatable{
   const HomeState({
     this.status=HomeStatus.initial,
    this.error="",
    this.isError=false,
    this.isLoading = false,
    this.isSucces = false,
    this.productsList,
     this.searchList,
     this.quantity=1
  });
   final HomeStatus status;
  final String error;
  final bool isSucces;
  final bool isLoading;
  final bool isError;
  final List<ProductEntity>? productsList;
   final List<ProductEntity>? searchList;
  final int quantity;

   static HomeState initial() =>  const HomeState(
     status: HomeStatus.initial,
     isLoading: false,
     isSucces: false,
     error: '',
     isError: false,
     productsList: null,
       quantity: 1,
     searchList: null
   );


  HomeState copyWith({
    HomeStatus? status,
     String? error,
     bool? isSucces,
     bool? isLoading,
     bool? isError,
    int? quantity,
     List<ProductEntity>? productsList,
     List<ProductEntity>? searchList
  }) {
    return HomeState(
        searchList: searchList ?? this.searchList,
        quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      error: error ?? this.error,
        isLoading: isLoading ?? this.isLoading,
        isError:isError ?? this.isError,
      isSucces : isSucces ?? this.isSucces,
      productsList:productsList ?? this.productsList

    );
  }

  @override
  List<Object?> get props => [productsList,isLoading,isError,isSucces,status,quantity,searchList];


}