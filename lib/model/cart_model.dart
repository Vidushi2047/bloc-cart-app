// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:bloc_cart_app/model/product.dart';

class Cart extends Equatable {
  List<Product> cartItems;

  Cart({
    required this.cartItems,
  });

  Cart copyWith(
      {int? id,
      String? title,
      String? image,
      String? price,
      String? description,
      int? quantity,
      bool? isFavorite}) {
    final updatedCartItems = [...cartItems];
    final index = updatedCartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      updatedCartItems[index] =
          updatedCartItems[index].copyWith(quantity: quantity);
    }
    return Cart(cartItems: updatedCartItems);
  }

  @override
  List<Object?> get props => [cartItems];
}
