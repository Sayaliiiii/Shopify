import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopify/features/Cart/presentation/bloc/cart_bloc.dart';
import 'package:shopify/features/Cart/presentation/cart_screen.dart';
import 'package:shopify/features/Home/presentation/bloc/home_bloc.dart';
import 'package:shopify/features/Home/presentation/home_screen.dart';
import 'package:shopify/features/Login/bloc/login_bloc.dart';
import 'package:shopify/features/Login/login_page.dart';
import 'package:shopify/features/Signup/presentation/bloc/sign_up_bloc.dart';

import 'injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(create: (context) => locator(),),
        BlocProvider<LoginBloc>(create: (context) => locator(),),
        BlocProvider<HomeCubit>(create: (context) => locator()..getProducts(),
          child: HomeScreen(isLogin: false),
        ),
        BlocProvider<CartCubit>(create: (context) => locator()..getCartProducts(),
          child: CartScreen(isLogged: false),
        )
      ],
      child: MaterialApp(
        title: 'Shopify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  LoginScreen(),
      ),
    );
  }
}

