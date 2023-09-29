import 'package:flutter/material.dart';
import 'package:shopify/core/utils/colors.dart';
import 'package:shopify/features/Cart/presentation/cart_screen.dart';

AppBar customAppBar(BuildContext context,bool isLogin){
  return AppBar(
    // automaticallyImplyLeading: false,
    // bottomOpacity: 0,
    backgroundColor:ColorsA().appbarColor,
    // backgroundColor: Colors.white,
    // elevation: 50,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.white),
    actions: [
      const Icon(
        Icons.person_4_outlined,
        size: 25,
      ),
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(isLogged: isLogin),
              ));
        },
        child: const Padding(
            padding: EdgeInsets.only(right: 8, left: 8),
            child: Icon(
              Icons.add_shopping_cart_outlined,
              size: 25,
            )),
      )
    ],
    title: const Text(
      "Shopify",
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}