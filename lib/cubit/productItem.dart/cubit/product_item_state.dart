// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_item_cubit.dart';

class ProductItemState {
  Product product;
  ProductItemState({
    required this.product,
  });

  ProductItemState copyWith({
    Product? product,
  }) {
    return ProductItemState(
      product: product ?? this.product,
    );
  }

  @override
  String toString() => 'ProductItemState(product: $product)';
}
