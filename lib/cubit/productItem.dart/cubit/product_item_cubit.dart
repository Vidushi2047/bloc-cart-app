import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/model/product.dart';
import 'package:equatable/equatable.dart';

part 'product_item_state.dart';

class ProductItemCubit extends Cubit<ProductItemState> {
  ProductItemCubit()
      : super(ProductItemState(
            product: Product(
                quantity: 0, id: 0, image: '', isFavorite: false, title: '')));
  showProduct(Product) {}
}
