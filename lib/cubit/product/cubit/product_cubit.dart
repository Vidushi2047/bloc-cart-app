import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/model/product.dart';
import 'package:bloc_cart_app/repository/product_repository.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super(InitProductState());

  Future<void> fetchProduct() async {
    emit(LoadingProductState());
    try {
      final response = await _productRepository.getProduct();

      emit(ResponseProductState(response));
    } catch (e) {
      print(e);
      emit(ErrorProductState(e.toString()));
    }
  }

  // @override
  // void onChange(Change<ProductState> change) {
  //   print(change);
  //   super.onChange(change);
  // }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print(error);
  //   super.onError(error, stackTrace);
  // }
}
