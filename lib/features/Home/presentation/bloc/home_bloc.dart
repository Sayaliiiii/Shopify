
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/Home/domain/Repositories/product_repository.dart';
import 'package:shopify/features/Home/domain/entities/product_entity.dart';
import 'package:shopify/features/Home/presentation/bloc/home_state.dart';
class HomeCubit extends Cubit<HomeState>{
  ProductRepository productRepository;
  HomeCubit({required this.productRepository}):super(HomeState.initial());




  void getProducts() async {
    emit(state.copyWith(isLoading: true, status: HomeStatus.loading));
    final result = await productRepository.getAllProducts();

    result.fold(
            (failure){
          emit(state.copyWith(error: failure.message,isLoading: false,isError: true,));
        },(data){
      emit(state.copyWith(productsList: data,isSucces: true,isLoading: false,searchList: data));
    }
    );
  }
  void getCateogryProducts(String cateogry) async {
    print('Datacheck ${cateogry}');
    emit(state.copyWith(isLoading: true, status: HomeStatus.loading,isSucces: false,isError: false));
    final result = await productRepository.getCateogryProducts(cateogry);

    result.fold(
            (failure){
          emit(state.copyWith(error: failure.message,isLoading: false,isError: true));
        },(data){
              print('Datacheck ${data}');
      emit(state.copyWith(productsList: data,isSucces: true,isLoading: false,searchList: data));
    }
    );
  }
  void searchBarChanged(String query) {
    emit(state.copyWith(isLoading: true,isSucces: false));
    if (query.isEmpty) {
      emit(state.copyWith(
          isSucces: true, productsList: state.searchList,isLoading: false));
    } else {
      print('eventcalled ');
      List<ProductEntity> filter = state.searchList!
          .where(
            (element) =>
            element.title.toLowerCase().contains(query.toLowerCase()),
      ).toList();
      print('model $filter');

      emit(state.copyWith(
          productsList: filter, isSucces: true,isLoading: false));
    }
  }
  void increseQuantity( int quantity){
    print('objectqq $quantity');
    emit(state.copyWith(quantity:quantity +1,));
    print('objectqq $quantity');
  }
  void decreaseQuantity( int quantity){
    if(quantity > 1){
    emit(state.copyWith(quantity:quantity-1, ));
  }}
  void resetQuantity(){
    emit(state.copyWith(quantity: 1, ));
  }
}