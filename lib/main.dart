import 'package:bloc_cart_app/bloc/bloc/bloc.dart';
import 'package:bloc_cart_app/bloc/bloc/theme_bloc.dart';
import 'package:bloc_cart_app/screen/Product_screen.dart';
import 'package:bloc_cart_app/widgets/aapBlocObserver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlockObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocWidget(
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, ThemeState state) {
          print('theme data-${state.themeData}');
          print('theme builder');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            // ThemeData(),
            // darkTheme: ThemeData.dark(),
            // themeMode: ThemeMode.dark,
            home: const ProductScreen(),
          );
        },
      ),
    );
  }
}
