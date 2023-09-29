import 'package:shopify/core/error/exception.dart';
import 'package:shopify/features/Cart/data/model/cart_response_model.dart';
import 'package:shopify/features/Home/data/Models/products_model.dart';
import 'package:http/http.dart'as http;
  abstract class CartRemoteDataSource{
  Future<CartResponseModel> getProductsInCart();
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource{
  @override
  Future<CartResponseModel> getProductsInCart() async {
    final response = await  http.get(Uri.parse('https://fakestoreapi.com/carts/user/2'));
    print("cart ${response.body}");
    if(response.statusCode ==200){
      return cartResponseModelFromJson(response.body)[0];
    }else{
      throw ServerException();
    }
  }


}