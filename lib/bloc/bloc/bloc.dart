import 'package:bloc_cart_app/bloc/bloc/theme_bloc.dart';
import 'package:bloc_cart_app/cubit/Favorite/cubit/favorite_cubit.dart';
import 'package:bloc_cart_app/cubit/cart/cubit/cart_cubit.dart';
import 'package:bloc_cart_app/cubit/product/cubit/product_cubit.dart';
import 'package:bloc_cart_app/cubit/productItem.dart/cubit/product_item_cubit.dart';
import 'package:bloc_cart_app/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocWidget extends StatelessWidget {
  const BlocWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ProductCubit(ProductRepository()),
      ),
      BlocProvider(
        lazy: false,
        create: (context) => CartCubit(),
      ),
      BlocProvider(
        create: (context) => FavoriteCubit(),
      ),
      BlocProvider(
        create: (context) => ProductItemCubit(),
      ),
      BlocProvider(
        create: (context) => ThemeBloc(),
      )
    ], child: child);
  }
}
