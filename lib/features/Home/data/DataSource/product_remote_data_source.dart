import 'package:shopify/core/error/exception.dart';
import 'package:shopify/features/Home/data/Models/cateogry_model.dart';
import 'package:shopify/features/Home/data/Models/products_model.dart';
import 'package:http/http.dart'as http;
abstract class ProductRemoteDataSource{
    Future<List<ProductsResponseModel>> getAllProducts();
    Future<List<CateogryModel>> getCateogryProducts(String cateogry);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource{
  @override
  Future<List<ProductsResponseModel>> getAllProducts() async {
      final response = await  http.get(Uri.parse('https://fakestoreapi.com/products'));
      if(response.statusCode ==200){
          return productsResponseModelFromJson(response.body);
      }else{
          throw ServerException();
      }
  }

  @override
  Future<List<CateogryModel>> getCateogryProducts(String cateogry)  async {
    final response = await  http.get(Uri.parse('https://fakestoreapi.com/products/category/$cateogry'));
    if(response.statusCode ==200){
      return cateogryModelFromJson(response.body);
    }else{
      throw ServerException();
    }
  }


}