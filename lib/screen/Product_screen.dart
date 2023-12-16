import 'package:bloc_cart_app/bloc/bloc/theme_bloc.dart';
import 'package:bloc_cart_app/cubit/Favorite/cubit/favorite_cubit.dart';
import 'package:bloc_cart_app/cubit/cart/cubit/cart_cubit.dart';
import 'package:bloc_cart_app/cubit/product/cubit/product_cubit.dart';
import 'package:bloc_cart_app/model/product.dart';
import 'package:bloc_cart_app/screen/ProductItem_screen.dart';
import 'package:bloc_cart_app/screen/favorite_screen.dart';
import 'package:bloc_cart_app/utils/aap_themes.dart';
import 'package:bloc_cart_app/utils/app_size.dart';
import 'package:bloc_cart_app/widgets/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<ProductCubit>();
      cubit.fetchProduct();
    });
  }

  var items = const ['B', 'G', 'P'];
  String dropdownValue = 'B';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: DropdownButton(
            value: dropdownValue,
            iconEnabledColor: Colors.white,
            icon: const Icon(Icons.settings),
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (value) {
              dropdownValue = value!;
              print("drop down - $value");
              setState(() {});
              AppTheme appTheme;
              if (value == 'B') {
                appTheme = AppTheme.brownTheme;
              } else if (value == 'G') {
                appTheme = AppTheme.greenTheme;
              } else {
                appTheme = AppTheme.purpleTheme;
              }
              print('aaptheme-$appTheme');
              context.read<ThemeBloc>().add(ThemeEvent(appTheme: appTheme));
            },
            onTap: () {
              print('object');
            }),
        title: const Text(
          'Product Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          const badges(),
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const FavoriteScreen();
                  },
                ));
              },
              icon: const Icon(
                Icons.favorite_border_rounded,
                color: Colors.red,
              ))
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          print('cart builder');
          if (state is InitProductState || state is LoadingProductState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResponseProductState) {
            final product = state.product;
            return ListView.builder(
              itemCount: product.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ItemScreen(
                          prod: Product(
                              quantity: product[index].quantity,
                              id: product[index].id,
                              image: product[index].image,
                              isFavorite: product[index].isFavorite,
                              title: product[index].title,
                              price: product[index].price,
                              description: product[index].description),
                        );
                      },
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: Sizes.p20, right: Sizes.p20, left: Sizes.p20),
                    child: Container(
                      padding: const EdgeInsets.all(Sizes.p10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.yellowAccent),
                        color: const Color.fromARGB(255, 250, 248, 236),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Image(
                                height: 150,
                                width: 150,
                                image: NetworkImage(
                                  product[index].image.toString(),
                                ),
                                fit: BoxFit.fill,
                              ),
                              gapH10,
                              Text(
                                'price - ${product[index].price.toString()}',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 75, 74, 74),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          gapW10,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product[index].id.toString()),
                                gapH10,
                                Text(product[index].title.toString()),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    try {
                                      context
                                          .read<CartCubit>()
                                          .addItem(product[index], 1, context);
                                    } catch (e) {
                                      print('error-$e');
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.brown,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<FavoriteCubit>()
                                        .addFav(product[index]);
                                    print(product[index].isFavorite);
                                  },
                                  icon: BlocConsumer<FavoriteCubit,
                                      FavoriteState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      final favorite = state.fav.favItems;
                                      final favoriteIndex = favorite.indexWhere(
                                          (element) =>
                                              element.id == product[index].id!);
                                      return Icon(
                                        Icons.favorite,
                                        color: favoriteIndex != -1
                                            ? Colors.red
                                            : Colors.grey,
                                      );
                                    },
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ErrorProductState) {
            return Text(state.message);
          }
          return Center(
            child: Text(state.toString()),
          );
        },
      ),
    );
  }
}
