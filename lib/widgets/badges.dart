import 'package:bloc_cart_app/cubit/cart/cubit/cart_cubit.dart';
import 'package:bloc_cart_app/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class badges extends StatefulWidget {
  const badges({super.key});

  @override
  State<badges> createState() => _badgesState();
}

class _badgesState extends State<badges> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const CartScreen();
                      },
                    ));
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  )),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.red,
                child: Text(
                  state.cart.cartItems!.length.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// class badges extends StatelessWidget {
//   const badges({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartCubit, CartState>(
//       builder: (context, state) {
//         return Stack(
//           children: [
//             Container(
//               margin: const EdgeInsets.all(5),
//               child: IconButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return const CartScreen();
//                       },
//                     ));
//                   },
//                   icon: const Icon(
//                     Icons.shopping_cart,
//                     color: Colors.white,
//                   )),
//             ),
//             if (state is LoadedState || state.list.isNotEmpty)
//               Positioned(
//                 top: 10,
//                 left: 10,
//                 child: CircleAvatar(
//                   radius: 8,
//                   backgroundColor: Colors.red,
//                   child: Text(
//                     state.list.length.toString(),
//                     style: const TextStyle(color: Colors.black, fontSize: 10),
//                   ),
//                 ),
//               ),
//           ],
//         );
//       },
//     );
//   }
// }
