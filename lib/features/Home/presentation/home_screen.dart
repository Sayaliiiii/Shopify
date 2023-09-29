import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/core/custom_widgets/appbar.dart';
import 'package:shopify/core/custom_widgets/drawer.dart';
import 'package:shopify/core/custom_widgets/textField_widget.dart';
import 'package:shopify/core/utils/colors.dart';
import 'package:shopify/features/Cart/presentation/cart_screen.dart';
import 'package:shopify/features/Home/domain/entities/product_entity.dart';
import 'package:shopify/features/Home/presentation/bloc/home_bloc.dart';
import 'package:shopify/features/Home/presentation/bloc/home_state.dart';
import 'package:shopify/features/Product/product_details.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../Cart/domain/entities/cart_entity.dart';

class HomeScreen extends StatelessWidget {
  bool isLogin;

  HomeScreen({super.key, required this.isLogin});

  int quantity = 1;
  final _accKey = GlobalKey();
  TextEditingController text = TextEditingController();
  String dropdownvalue = 'ALL';

  // List of items in our dropdown menu
  var items = [
    'ALL',
    'ELECTRONICS',
    "MEN'S CLOTHING",
    "WOMEN'S CLOTHING",
    'JEWELERY',
  ];
  final List<String> imglist = [
    "assets/images/slider.jpg",
    "assets/images/slider2.jpg"
  ];

  // List<ProductEntity> proucts=[];
  // bool isLogged=isLogin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, isLogin),
      drawer: customDrawer(context, isLogin),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          // color:hexStringToColor("BCF4DE") ,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(30),
                        // color: hexStringToColor("83bca9"),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: reusableTextField(
                            isSearch: true,
                            text: "Search",
                            icon: Icons.search,
                            isPasswordType: false,
                            controller: text,
                            onChange: (p0) {
                              context.read<HomeCubit>()
                                ..searchBarChanged(text.text);
                            },
                          ),
                        ),
                        filterWidget(context)
                      ],
                    )),
              ),
              SizedBox(height: 15),
              CarouselSlider(
                items: imglist
                    .map((e) => ClipRRect(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height / 70,
                              child: Image.asset(e, fit: BoxFit.cover)),
                          borderRadius: BorderRadius.circular(15),
                        ))
                    .toList(),
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 18 / 8,
                    onPageChanged: (index, other) {}),
              ),
              SizedBox(height: 25),
              // BlocBuilder<HomeCubit, HomeState>(
              //   builder: (context, state) {
              //     return Align(
              //       alignment: Alignment.topLeft,
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 10.0, bottom: 5),
              //         child: Container(
              //             width: MediaQuery.of(context).size.width * 0.89,
              //             padding: const EdgeInsets.all(8),
              //             height: 60,
              //             decoration: BoxDecoration(
              //               border: Border.all(
              //                   color: ColorsA().borderColor, width: 5),
              //               // borderRadius: BorderRadius.circular(30),
              //               color: Colors.white,
              //             ),
              //             child: Row(
              //                 mainAxisAlignment:
              //                     MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     'Cateogry',
              //                     style: TextStyle(
              //                         color: Colors.black, fontSize: 20),
              //                   ),
              //                   DropdownButton(
              //                     // Initial Value
              //                     value: dropdownvalue,
              //                     // Down Arrow Icon
              //                     icon:
              //                         const Icon(Icons.keyboard_arrow_down),
              //                     // Array list of items
              //                     items: items.map((String items) {
              //                       return DropdownMenuItem(
              //                         value: items,
              //                         child: Text(items),
              //                       );
              //                     }).toList(),
              //                     // After selecting the desired option,it will
              //                     // change button value to selected value
              //                     onChanged: (String? newValue) {
              //                       // setState(() {
              //                       dropdownvalue = newValue ?? "ALL";
              //                       // });
              //                       if (dropdownvalue == "ALL") {
              //                         context.read<HomeCubit>()
              //                           ..getProducts();
              //                       } else {
              //                         print(
              //                             "women's clothing ${newValue!.toLowerCase()}");
              //                         context.read<HomeCubit>()
              //                           ..getCateogryProducts(
              //                               dropdownvalue.toLowerCase());
              //                       }
              //                     },
              //                     underline: SizedBox(),
              //                   ),
              //                 ])),
              //       ),
              //     );
              //   },
              // ),
              const SizedBox(
                height: 13,
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.isError) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  if (state.isSucces) {
                    final product = state.productsList;
                    // proucts=product!;
                    return GridView.builder(
                      physics: ScrollPhysics(),
                      itemCount: product!.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        mainAxisExtent: 330,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                    product: product[index],
                                    isLogged: isLogin,
                                  ),
                                ));
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 15,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                height: 250,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorsA().appbarColor, width: 1),
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white54,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('${product[index].rate}/5'),
                                          Icon(
                                            Icons.star_outline,
                                            color: Colors.black,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 14),
                                      height: 150,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.network(
                                            product![index].image,
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(product[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(
                                          color: ColorsA().appbarColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Price',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text("${product[index].price} \$",
                                              textAlign: TextAlign.start,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
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
                                                    print('addToCart');
                                                    Cart().addToCart(
                                                        product[index],
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
                                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
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
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.add_shopping_cart_sharp,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ]),
          )),
    );
  }

  Widget filterWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        final RenderBox renderBox =
            _accKey.currentContext?.findRenderObject() as RenderBox;
        final Size size = renderBox.size;
        final Offset offset = renderBox.localToGlobal(Offset.zero);

        showMenu(
            context: context,
            position: RelativeRect.fromLTRB(offset.dx, offset.dy + size.height,
                offset.dx + size.width, offset.dy + size.height),
            items: [
              PopupMenuItem<String>(
                child: const Text('ELECTRONICS'),
                value: 'electronics',
                onTap: () => context.read<HomeCubit>()
                  ..getCateogryProducts('electronics'),
              ),
              PopupMenuItem<String>(
                child: const Text('JEWELERY'),
                value: "jewelery",
                onTap: () =>
                    context.read<HomeCubit>()..getCateogryProducts('jewelery'),
              ),
              PopupMenuItem<String>(
                child: const Text("MEN'S CLOTHING"),
                value: "men's clothing",
                onTap: () => context.read<HomeCubit>()
                  ..getCateogryProducts("men's clothing"),
              ),
              PopupMenuItem<String>(
                child: const Text("WOMEN'S CLOTHING"),
                value: "women's clothing",
                onTap: () => context.read<HomeCubit>()
                  ..getCateogryProducts("women's clothing"),
              ),
              PopupMenuItem<String>(
                child: const Text("ALL"),
                value: "all",
                onTap: () => context.read<HomeCubit>()..getProducts(),
              ),
            ]);
      },
      child: Icon(key: _accKey, Icons.filter_alt_sharp),
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
