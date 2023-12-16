part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  Fav fav;
  FavoriteState({
    required this.fav,
  });
  factory FavoriteState.initial() {
    return FavoriteState(fav: Fav(favItems: const []));
  }
  FavoriteState copyWith({
    Fav? fav,
  }) {
    return FavoriteState(
      fav: fav ?? this.fav,
    );
  }

  @override
  String toString() => 'FavoriteState(fav: $fav)';

  @override
  List<Object?> get props => [fav];
}
