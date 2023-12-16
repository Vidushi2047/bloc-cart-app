import 'package:bloc/bloc.dart';
import 'package:bloc_cart_app/model/favorite_model.dart';
import 'package:bloc_cart_app/model/product.dart';
import 'package:equatable/equatable.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState.initial());
  void addFav(Product product) {
    final state = this.state;
    var list = [...state.fav.favItems];
    int itemindex = list.indexWhere((element) => element.id == product.id);
    if (itemindex != -1) {
      list.removeWhere((element) => element.id == product.id);
    } else {
      list.add(Product(
          quantity: product.quantity,
          id: product.id,
          image: product.image,
          isFavorite: !product.isFavorite,
          title: product.title));
    }

    emit(state.copyWith(fav: Fav(favItems: list)));
  }

  // @override
  // void onChange(Change<FavoriteState> change) {
  //   print('favoriteCubit-$change');
  //   super.onChange(change);
  // }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print('favoriteCubit-$error');
  //   super.onError(error, stackTrace);
  // }
}
