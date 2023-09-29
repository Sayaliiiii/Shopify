import 'package:bloc/bloc.dart';
import 'package:shopify/features/Cart/domain/entities/cart_entity.dart';
import 'package:shopify/features/Cart/domain/repositories/cart_repository.dart';
import 'package:shopify/features/Cart/presentation/bloc/cart_state.dart';

class CartCubit extends Cubit<CartState>{
  CartRepository cartRepository;
  CartCubit({required this.cartRepository}):super(CartState());

  void getCartProducts() async{
    print('eve');
    emit(state.copyWith(isLoading: true));

    final response = await Cart().getCartProducts();
    print('object $response');
    final total=await Cart().getTotal();
    print('object $total');
    print('response1 $response');
    if(response.isEmpty){
      emit(state.copyWith(isError: true,error: "Cart is Empty ",isLoading: false,total: 0));

    }else{
      emit(state.copyWith(isSuccess: true,cartProductList: response,isLoading: false,total: total.toInt()+1));

    }

    // final response = await  cartRepository.getCartProducts();
    // response.fold((l) {
    //   emit(state.copyWith(isError: true,error: l.message));
    // }, (r) {
    //   emit(state.copyWith(isSuccess: true,isLoading: false,cartProductList: r));
    // });

  }


}