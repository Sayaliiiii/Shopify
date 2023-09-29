import 'package:get_it/get_it.dart';
import 'package:shopify/features/Cart/data/data_source/cart_remote_data_source.dart';
import 'package:shopify/features/Cart/data/services/cart_service.dart';
import 'package:shopify/features/Cart/domain/repositories/cart_repository.dart';
import 'package:shopify/features/Cart/presentation/bloc/cart_bloc.dart';
import 'package:shopify/features/Home/data/DataSource/product_remote_data_source.dart';
import 'package:shopify/features/Home/data/Services/product_service.dart';
import 'package:shopify/features/Home/domain/Repositories/product_repository.dart';
import 'package:shopify/features/Home/presentation/bloc/home_bloc.dart';
import 'package:shopify/features/Login/bloc/login_bloc.dart';
import 'package:shopify/features/Signup/presentation/bloc/sign_up_bloc.dart';

final locator= GetIt.instance;

void setUpLocator(){
  locator.registerFactory(() => HomeCubit(productRepository: locator()));
  locator.registerFactory(() => SignUpBloc());
  locator.registerFactory(() => LoginBloc());
  locator.registerFactory(() => CartCubit(cartRepository: locator()));

  locator.registerSingleton<ProductRemoteDataSource>(ProductRemoteDataSourceImpl());
  locator.registerSingleton<ProductRepository>(ProductService(productRemoteDataSource: locator()));

  locator.registerSingleton<CartRemoteDataSource>(CartRemoteDataSourceImpl());
  locator.registerSingleton<CartRepository>(CartService(cartRemoteDataSource: locator()));


}