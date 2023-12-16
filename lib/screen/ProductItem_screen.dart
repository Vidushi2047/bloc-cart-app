// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_cart_app/cubit/cart/cubit/cart_cubit.dart';
import 'package:bloc_cart_app/cubit/product/cubit/product_cubit.dart';
import 'package:bloc_cart_app/model/product.dart';
import 'package:bloc_cart_app/utils/app_size.dart';
import 'package:bloc_cart_app/widgets/badges.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({
    Key? key,
    required this.prod,
  }) : super(key: key);

  final Product prod;

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  late int value = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item Screen',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [
          badges(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p20, vertical: Sizes.p20),
          child: Column(
            children: [
              Image(
                height: 200,
                width: 200,
                image: NetworkImage(widget.prod.image.toString()),
                fit: BoxFit.fill,
              ),
              gapH20,
              Text(
                widget.prod.title.toString(),
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              gapH10,
              Text(
                widget.prod.description.toString(),
                style: TextStyle(
                    color: const Color.fromARGB(255, 73, 72, 72),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              gapH10,
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'price - ${widget.prod.price.toString()}',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 75, 74, 74),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              gapH20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.brown.withOpacity(0.3),
                    radius: 20,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            value++;
                            print(value);
                          });
                        },
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        )),
                  ),
                  gapW20,
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black)),
                    child: Text(value.toString()),
                  ),
                  gapW20,
                  CircleAvatar(
                    backgroundColor: Colors.brown.withOpacity(0.3),
                    radius: 20,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (value > 1) {
                              value--;
                            }
                          });
                          print(value);
                        },
                        child: const Icon(
                          Icons.remove,
                          color: Colors.black,
                        )),
                  ),
                ],
              ),
              gapH20,
              GestureDetector(
                onTap: () {
                  print('add item');
                  context
                      .read<CartCubit>()
                      .addItem(widget.prod, value, context);
                },
                child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 40, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.brown)),
                  child: const Text(
                    'Add Cart',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
