import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/custom_widgets/appbar.dart';
import 'package:shopify/core/custom_widgets/drawer.dart';
import 'package:shopify/core/utils/colors.dart';
import 'package:shopify/features/Home/domain/entities/product_entity.dart';
import 'package:shopify/features/Home/presentation/bloc/home_bloc.dart';
import 'package:shopify/features/Home/presentation/bloc/home_state.dart';

import '../Cart/domain/entities/cart_entity.dart';

class ProductDetail extends StatelessWidget {
  bool isLogged;
  ProductEntity product;

  ProductDetail({super.key, required this.isLogged,required this.product});

  int quantity=1;
  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customAppBar(context, isLogged),
      drawer: customDrawer(context, isLogged),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(colors: [
          //   hexStringToColor("CB2B93"),
          //   hexStringToColor("9546C4"),
          //   hexStringToColor("5E61F4")
          // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Center(
                  child: Container(
                    // color: hexStringToColor("03045e"),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width*0.7,
                    height: MediaQuery.of(context).size.height * .45,
                    child: Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width * .7,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // color: hexStringToColor("03045e"),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.network(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                '${product.title}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        'DESCRIPTION :',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(product.description,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),maxLines: 2,),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: w! * 0.4,
                            child: Text('CATEOGRY',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800)),
                          ),
                          SizedBox(
                            width: w! * 0.40,
                            child: Text(product.category.toUpperCase(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: w! * 0.4,
                        child: Text('RATING',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w800)),
                      ),
                      SizedBox(
                        width: w! * 0.40,
                        child: Row(
                          children: [
                            Text('${product.rate}/5',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                            Icon(Icons.star,size: 18,)
                          ],
                        ),
                      ),
                    ],
                  ),
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: w! * 0.4,
                            child: Text('PRICE',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800)),
                          ),
                          SizedBox(
                            width: w! * 0.40,
                            child: Text('${product.price.toInt() +1} \$',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),
                      InkWell(
                        onTap: () {
                          context
                              .read<HomeCubit>()
                              .resetQuantity();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text('Select Quantity'),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    BlocBuilder<HomeCubit,
                                        HomeState>(
                                      builder: (context, state) {
                                        quantity = state.quantity;
                                        return selectQuantity(
                                            quantity, context);
                                      },
                                    )
                                  ],
                                ),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Cart().addToCart(
                                          product,
                                          quantity);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Add',
                                      style:
                                      TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: ColorsA().appbarColor,
                              borderRadius:
                              BorderRadius.circular(10)),
                          child: const Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Add to Cart',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.add_shopping_cart_sharp,color: Colors.white,)
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
  Widget selectQuantity(int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () => context.read<HomeCubit>().decreaseQuantity(index),
            child: Icon(
              Icons.horizontal_rule,
              size: 35,
            )),
        SizedBox(
          width: 20,
        ),
        Text(
          '$index',
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
            onTap: () => context.read<HomeCubit>().increseQuantity(index),
            child: Icon(
              Icons.add,
              size: 35,
            )),
      ],
    );
  }
}
