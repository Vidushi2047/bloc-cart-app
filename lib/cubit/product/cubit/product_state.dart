// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_cubit.dart';

abstract class ProductState {}

class InitProductState extends ProductState {}

class LoadingProductState extends ProductState {}

class ErrorProductState extends ProductState {
  final String message;
  ErrorProductState(this.message);
}

class ResponseProductState extends ProductState {
  List<Product> product;
  ResponseProductState(this.product);

  ResponseProductState copyWith({
    List<Product>? product,
  }) {
    return ResponseProductState(
      product ?? this.product,
    );
  }
}

class ManageQuantityState extends ProductState {}
