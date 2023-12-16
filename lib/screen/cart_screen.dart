import 'package:bloc_cart_app/cubit/cart/cubit/cart_cubit.dart';
import 'package:bloc_cart_app/screen/favorite_screen.dart';
import 'package:bloc_cart_app/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const FavoriteScreen();
                  },
                ));
              },
              icon: const Icon(
                Icons.favorite_border_outlined,
                color: Colors.red,
              )),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: size.width,
            child: BlocBuilder<CartCubit, CartState>(
                buildWhen: (previes, current) {
              return current.cart.cartItems.length !=
                      current.cart.cartItems.length ||
                  current.isDelete == true;
            }, builder: (context, state) {
              print('builder');
              // print('state-${state.toString()}');
              context.read<CartCubit>().totalPrice();
              final itemsList = state.cart.cartItems;
              print('cart-$itemsList');
              return ListView.builder(
                itemCount: itemsList.length,
                padding: const EdgeInsetsDirectional.only(bottom: 60),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: Sizes.p20, right: Sizes.p20, left: Sizes.p20),
                    child: Container(
                      padding: const EdgeInsets.all(Sizes.p10),
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: Colors.yellowAccent),
                        color: const Color.fromARGB(255, 250, 248, 236),
                      ),
                      child: Column(
                        children: [
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context1, state1) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Image(
                                        height: 150,
                                        width: 150,
                                        image: NetworkImage(
                                          itemsList[index].image.toString(),
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      gapH10,
                                      Text(
                                        'price - ${itemsList[index].price.toString()} ',
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 75, 74, 74),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      gapH20,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            child: TextButton(
                                                onPressed: () {
                                                  context1
                                                      .read<CartCubit>()
                                                      .increment(index);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.brown,
                                                )),
                                          ),
                                          gapW20,
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.brown)),
                                            child: Text(state1
                                                .cart.cartItems[index].quantity
                                                .toString()),
                                          ),
                                          gapW20,
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            child: TextButton(
                                                onPressed: () {
                                                  if (state1
                                                          .cart
                                                          .cartItems[index]
                                                          .quantity >
                                                      1) {
                                                    context1
                                                        .read<CartCubit>()
                                                        .decrement(index);
                                                  } else {
                                                    context
                                                        .read<CartCubit>()
                                                        .deleteItem(
                                                            itemsList[index]);
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.brown,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  gapW20,
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(itemsList[index].id.toString()),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Column(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            // context
                                            //     .read<CartCubit>()
                                            //     .deleteItem1(index);

                                            context
                                                .read<CartCubit>()
                                                .deleteItem(itemsList[index]);
                                          },
                                          child: const Text(
                                            'remove',
                                            style: TextStyle(
                                              color: Colors.red,
                                            ),
                                          )),
                                      GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                              padding: const EdgeInsets.all(
                                                  Sizes.p10),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.brown,
                                                      width: 1)),
                                              child: const Text('Buy Now')))
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Positioned(
              bottom: 0,
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  context.read<CartCubit>().totalPrice();
                  var num1 = state.total;
                  var num2 = double.parse(num1.toStringAsFixed(2));
                  return Container(
                    width: size.width,
                    height: 50,
                    color: Colors.brown.shade200,
                    child: Center(
                      child: Text(
                        'Total Rate - $num2',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}
