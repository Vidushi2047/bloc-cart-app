import 'package:bloc_cart_app/bloc/bloc/theme_bloc.dart';
import 'package:bloc_cart_app/cubit/Favorite/cubit/favorite_cubit.dart';
import 'package:bloc_cart_app/cubit/cart/cubit/cart_cubit.dart';
import 'package:bloc_cart_app/cubit/product/cubit/product_cubit.dart';
import 'package:bloc_cart_app/cubit/productItem.dart/cubit/product_item_cubit.dart';
import 'package:bloc_cart_app/screen/Product_screen.dart';
import 'package:bloc_cart_app/widgets/aapBlocObserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/product_repository.dart';

void main() {
  Bloc.observer = AppBlockObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, ThemeState state) {
          print('theme data-${state.themeData}');
          print('theme builder');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            // ThemeData(),
            // darkTheme: ThemeData.dark(),
            // themeMode: ThemeMode.dark,
            home: const ProductScreen(),
          );
        },
      ),
    );
  }
}
