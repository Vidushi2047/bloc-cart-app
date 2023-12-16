import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/model/cart_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../model/product.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  void addItem(Product product, int val, BuildContext context) {
    print('id-${product.id}');
    final state = this.state;

    var list = [...state.cart.cartItems];

    double total = 0;

    int itemIndex = list.indexWhere((element) => element.id == product.id);
    if (itemIndex != -1) {
      var item = Product(
          id: product.id,
          image: product.image,
          price: product.price,
          title: product.title,
          quantity: list[itemIndex].quantity + val);
      list[itemIndex] = item;
      // total = state.total + double.parse(product.price!) * item.quantity;
      print(item);
    } else {
      list.add(Product(
          quantity: product.quantity + val,
          id: product.id,
          image: product.image,
          price: product.price,
          title: product.title));
      // total =
      //     state.total + double.parse(product.price!) * (product.quantity + val);
    }

    emit(state.copyWith(
        cart: Cart(
          cartItems: list,
        ),
        isDelete: false,
        total: total));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item is Added Successfully'),
        duration: Duration(milliseconds: 60 * 5),
      ),
    );
  }

  void deleteItem(Product product) {
    print('id-${product.id}');
    final state = this.state;
    var list = [...state.cart.cartItems];
    print('list-$list');
    print('product-$product');
    int index = list.indexOf(product);

    // double total =
    //     state.total - (double.parse(list[index].price!) * list[index].quantity);
    list.removeWhere((element) => element.id == product.id);
    emit(
      state.copyWith(
        cart: Cart(cartItems: list),
        isDelete: true,
      ),
    );
  }

  void deleteItem1(index) {
    final state = this.state;
    var list = [...state.cart.cartItems];
    print('list-$list');

    print('idex-$index');
    // double total =
    //     state.total - (double.parse(list[index].price!) * list[index].quantity);
    list.removeAt(index);
    emit(
      state.copyWith(
        cart: Cart(cartItems: list),
        isDelete: true,
      ),
    );
  }

  void decrement(int index) {
    final list = [...state.cart.cartItems];
    list[index] = list[index].copyWith(quantity: list[index].quantity - 1);
    // double total = state.total + double.parse(list[index].price!);

    emit(state.copyWith(
      cart: Cart(cartItems: list),
    ));
  }

  void increment(int index) {
    print('increment');
    final list = [...state.cart.cartItems];
    list[index] = list[index].copyWith(quantity: list[index].quantity + 1);
    // double total = state.total + double.parse(list[index].price!);

    emit(
      state.copyWith(
        cart: Cart(
          cartItems: list,
        ),
      ),
    );
  }

  void totalPrice() {
    final state = this.state;
    final list = [...state.cart.cartItems];
    double total = 0;

    list.forEach((element) {
      total = total + element.quantity * double.parse(element.price!);
    });

    emit(state.copyWith(cart: Cart(cartItems: list), total: total));
  }

  // @override
  // void onChange(Change<CartState> change) {
  //   print('cartCubit-$change');
  //   super.onChange(change);
  // }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print('cartCubit-$error');
  //   super.onError(error, stackTrace);
  // }
}
