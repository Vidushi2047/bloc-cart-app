// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

class CartState extends Equatable {
  Cart cart;
  bool isDelete;
  double total;
  CartState({required this.cart, this.isDelete = false, this.total = 0});
  factory CartState.initial() {
    return CartState(
        cart: Cart(cartItems: const []), isDelete: false, total: 0);
  }

  @override
  List<Object?> get props => [cart, isDelete, total];

  CartState copyWith({Cart? cart, bool? isDelete, double? total}) {
    return CartState(
        cart: cart ?? this.cart,
        isDelete: isDelete ?? this.isDelete,
        total: total ?? this.total);
  }

  @override
  bool get stringify => true;
}
