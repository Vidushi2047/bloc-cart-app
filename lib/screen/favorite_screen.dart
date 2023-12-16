import 'package:bloc_cart_app/cubit/Favorite/cubit/favorite_cubit.dart';
import 'package:bloc_cart_app/cubit/cart/cubit/cart_cubit.dart';
import 'package:bloc_cart_app/utils/app_size.dart';
import 'package:bloc_cart_app/widgets/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Favorite Screen',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: const [
            badges(),
          ],
        ),
        body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            final favorite = state.fav.favItems;
            return SingleChildScrollView(
              child: Column(
                children: List.generate(
                    favorite.length,
                    (index) => Padding(
                        padding: const EdgeInsets.only(
                            top: Sizes.p20, right: Sizes.p20, left: Sizes.p20),
                        child: Container(
                          padding: const EdgeInsets.all(Sizes.p10),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.yellowAccent),
                            color: const Color.fromARGB(255, 250, 248, 236),
                          ),
                          child: Row(
                            children: [
                              Image(
                                height: 150,
                                width: 150,
                                image: NetworkImage(
                                  favorite[index].image.toString(),
                                ),
                                fit: BoxFit.fill,
                              ),
                              gapW20,
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      (favorite[index].id).toString(),
                                    ),
                                    gapH10,
                                    Text(
                                      (favorite[index].title).toString(),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              BlocBuilder<FavoriteCubit, FavoriteState>(
                                builder: (context, state) {
                                  final favoriteIndex = favorite.indexWhere(
                                      (element) =>
                                          element.id == favorite[index].id!);
                                  return Column(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            context
                                                .read<FavoriteCubit>()
                                                .addFav(favorite[index]);
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: favoriteIndex != -1
                                                ? Colors.red
                                                : Colors.grey,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            try {
                                              context.read<CartCubit>().addItem(
                                                  favorite[index], 1, context);
                                            } catch (e) {
                                              print('error-$e');
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          )),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ))),
              ),
            );
          },
        ));
  }
}
