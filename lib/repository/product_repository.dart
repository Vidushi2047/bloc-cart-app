import 'dart:convert';
import 'package:bloc_cart_app/model/product.dart';

import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<Product>> getProduct() async {
    String url = 'https://fakestoreapi.com/products';
    final response = await http.get(Uri.parse(url));
    print('response.statusCode - ${response.statusCode}');
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final result = json
          .map((e) => Product(
              id: e['id'],
              image: e['image'],
              quantity: 0,
              title: e['title'],
              price: e['price'].toString(),
              description: e['description'],
              isFavorite: false))
          .toList();
      print(json);
      return result;
    } else {
      throw 'something went wrong and status code is ${response.statusCode}';
    }
  }
}

// class ProductRepository {
//   Future<List<ProductModel>> getProduct() async {
//     String url = 'https://fakestoreapi.com/products';
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body) as List;
//       final result = json
//           .map((e) => ProductModel(
//                 id: e['id'],
//                 image: e['image'],
//                 quantity: 1,
//                 title: e['title'],
//               ))
//           .toList();
//       print(json);
//       return result;
//     } else {
//       throw 'something went wrong and status code is ${response.statusCode}';
//     }
//   }
// }
