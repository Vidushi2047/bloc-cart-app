// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:bloc_cart_app/model/product.dart';

class Fav extends Equatable {
  List<Product> favItems;

  Fav({
    required this.favItems,
  });

  Fav copyWith(
      {int? id,
      String? title,
      String? image,
      String? price,
      int? quantity,
      bool? isFavorite}) {
    final updatedCartItems = [...favItems];
    final index = updatedCartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      updatedCartItems[index] =
          updatedCartItems[index].copyWith(isFavorite: isFavorite);
    }
    return Fav(favItems: updatedCartItems);
  }

  @override
  List<Object?> get props => [favItems];
}
