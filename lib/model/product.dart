// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String? title;
  final String? image;
  final String? price;
  final String? description;
  int quantity = 0;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.image,
    this.price,
    this.description,
    required this.quantity,
    this.isFavorite = false,
  });

  Product copyWith(
      {int? id,
      String? title,
      String? image,
      String? price,
      String? description,
      int? quantity,
      bool? isFavorite}) {
    return Product(
        quantity: quantity ?? this.quantity,
        title: title ?? this.title,
        price: price ?? this.price,
        id: id ?? this.id,
        image: image ?? this.image,
        description: description ?? this.description,
        isFavorite: isFavorite ?? this.isFavorite);
  }

  @override
  List<Object?> get props =>
      [id, title, image, quantity, isFavorite, price, description];
}
