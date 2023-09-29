

import '../../data/model/cart_response_model.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/features/Home/data/Models/products_model.dart';
import 'package:shopify/features/Home/domain/entities/product_entity.dart';

class Cart {
  List<CartModel> items = [];
  final String cartKey = 'cart';
  final String qtKey = 'quantity';
  double total=0;

  Future<double> getTotal () async{
    await loadCart();
    for (int i=0; i < items.length ;i++){
      total= total +  items[i].price * items[i].quantity;
    }

    return total;
  }


 loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString(cartKey);
    print('1121');
    if (cartData != null && cartData !='') {
      print('1121');
      final cartItems = cartModelFromJson(cartData);
      items.addAll(cartItems);
    }
    print('1221');

  }
  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    // List<CartModel> emptyCart = [];
    prefs.setString(cartKey,'');
  }
  Future<List<CartModel>> getCartProducts() async{
   print('111');
   await loadCart();
   print('1111');
   if(items.isEmpty){
     print('11111');
     return [];
   }else{
     print('1111111 $items');
   return items;
   }


  }

  void saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = cartModelToJson(items);
    prefs.setString(cartKey, cartData);
  }

  Future<void> addToCart(ProductEntity e,int quantity) async {
    await loadCart();
    final cartItem= CartModel(id: e.id, title: e.title, price: e.price, quantity: quantity,  image: e.image);
    items.add(cartItem);
    print('item addedd $items');
    saveCart(); // Save the updated cart
  }
  Future<void> removeFromCart(int e)async {
    await loadCart();
    print('items ${items.length}');
    items.removeAt(e);
    print('items ${items.length}');
    saveCart(); // Save the updated cart
  }

  bool isInCart(ProductEntity e,int? quantity) {
    final cartItem= CartModel(id: e.id, title: e.title, price: e.price, quantity: quantity ?? 1,  image: e.image);
    return items.contains(cartItem);
  }
}




class CartEntity{
  CartEntity({
    required this.id,
    required this.userId,
    required this.date,
    required this.v,
    required this.products
  });
  int id;
  int userId;
  DateTime date;
  int v;
  List<Product> products;


}
