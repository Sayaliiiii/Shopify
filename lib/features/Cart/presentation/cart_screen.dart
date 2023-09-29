import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/constants/sharedPref.dart';
import 'package:shopify/core/custom_widgets/appbar.dart';
import 'package:shopify/core/custom_widgets/custom_button.dart';
import 'package:shopify/core/custom_widgets/drawer.dart';
import 'package:shopify/core/utils/colors.dart';
import 'package:shopify/features/Cart/data/model/cart_response_model.dart';
import 'package:shopify/features/Cart/domain/entities/cart_entity.dart';
import 'package:shopify/features/Cart/presentation/bloc/cart_bloc.dart';
import 'package:shopify/features/Cart/presentation/bloc/cart_state.dart';
import 'package:shopify/features/Home/presentation/bloc/home_bloc.dart';
import 'package:shopify/features/Home/presentation/bloc/home_state.dart';
import 'package:shopify/features/Home/presentation/home_screen.dart';
import 'package:shopify/features/Signup/presentation/sign_up.dart';
import 'package:shopify/injection.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key, required this.isLogged});
  bool isLogged;

  // void getLogged() async{
  //   isLogged= await UserPreferences.getLogged() ;
  // }
  ConfettiController confettiController =ConfettiController(duration: const Duration(seconds: 5));

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    // getLogged();
    double w=MediaQuery.of(context).size.width;

    return BlocProvider<CartCubit>(
      create: (context) =>
          CartCubit(cartRepository: locator())..getCartProducts(),
      child: Scaffold(
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height*0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text('Your Cart!!!',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          BlocConsumer<CartCubit, CartState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                // print('qtt $quantity');
                                print("check${state.status}");
                                if (state.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (state.isError) {
                                  return SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: Text(
                                        state.error,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  );
                                }
                                if (state.isSuccess) {
                                  var cart = state.cartProductList;
                                  return SingleChildScrollView(
                                    child: ListView.builder(
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: cart!.length,
                                        itemBuilder: (context, index) {
                                          return getCartProductCard(
                                              data:
                                                  state.cartProductList![index],
                                              index: index,
                                              context: context);
                                        }),
                                  );
                                }
                                return SizedBox();
                              })
                        ],
                      ),
                    ),
                    BlocBuilder<CartCubit, CartState>(
                        builder: (context, state) {
                      int index = state.cartProductList?.length ?? 0;
                      if (index < 4) {
                        return SizedBox(
                          height: (4 - index) * 110,
                        );
                      }
                      if (index == 4) {
                        return SizedBox(
                          height: 50
                        );
                      }
                      return SizedBox(height: 45,);
                    }),
                    BlocBuilder<CartCubit,CartState>(
                      builder: (context, state) {
                        // if(state.isSuccess){
                        //
                        // }
                        return Container(
                          // padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          margin: const EdgeInsets.fromLTRB(15, 10, 25, 0),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(90),
                            color: Colors.white
                          ),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Grand Total:  ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800)),

                                    Text('${state.total}\$',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800)),



                            ],
                          ),
                        );
                      },

                    ),
                    CustomButton(
                        context: context,
                        title: isLogged ? "Checkout" : "Checkout as Guest",
                        onTap: () async {
                          if (isLogged) {
                            confettiController.play();
                            await Cart().clearCart();
                             showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  // Future.delayed(Duration(seconds: 5), () {
                                  //   Navigator.of(context).pop(true);
                                  // });
                                  return  AlertDialog(

                                    title: Column(
                                      children: [
                                        SizedBox(height: MediaQuery.of(context).size.height*0.4,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'YAY!!!  \n Order Placed Succesfully ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: ConfettiWidget(
                                            confettiController: confettiController,
                                            blastDirectionality: BlastDirectionality
                                                .explosive, // don't specify a direction, blast randomly
                                            shouldLoop:
                                            true, // start again as soon as the animation is finished
                                            colors: const [
                                              Colors.green,
                                              Colors.blue,
                                              Colors.pink,
                                              Colors.orange,
                                              Colors.purple
                                            ], // manually specify the colors to be used
                                            createParticlePath: drawStar,

                                          ),
                                        ),


                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomButton(context: context, title: 'Home', onTap: (){
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (context) {
                                                return HomeScreen(isLogin: true,);
                                              }));
                                        })


                                      ],
                                    ),
                                  );
                                });

                          } else {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return SignupScreen(
                                  isGuest: true,
                                );
                              },
                            ));
                          }
                        })
                  ],
                ),
              ),
            )),
      ),
    );
  }

  getCartProductCard(
      {required CartModel data,
      required int index,
      required BuildContext context}) {
    double total=(data.quantity)*(data.price);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 70,
                width: 70,
                child: Image.network(
                  data.image,
                  fit: BoxFit.contain,
                )),
            SizedBox(
              width: 185,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${data.title}',
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black)),
                  const SizedBox(
                    height: 1,
                  ),
                  RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    softWrap: true,
                    maxLines: 1,
                    textScaleFactor: 1,
                    text: TextSpan(
                      text: ' Price: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${data.price}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    softWrap: true,
                    maxLines: 1,
                    textScaleFactor: 1,
                    text: TextSpan(
                      text: ' Quantity: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${data.quantity}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  RichText(
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    softWrap: true,
                    maxLines: 1,
                    textScaleFactor: 1,
                    text: TextSpan(
                      text: 'Total: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text:'$total\$' ,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: () async {
                  await Cart().removeFromCart(index);
                  context.read<CartCubit>()..getCartProducts();
                },
                child: Icon(Icons.delete_forever_outlined))
          ],
        ),
      ),
    );
  }
}
