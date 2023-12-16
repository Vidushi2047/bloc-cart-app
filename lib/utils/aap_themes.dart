import 'package:flutter/material.dart';

class AppThemes {
  var AppThemesData = {
    AppTheme.brownTheme: ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.brown),
      scaffoldBackgroundColor: Colors.brown.shade100,
      backgroundColor: Colors.brown.shade100,
    ),
    AppTheme.greenTheme: ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.green),
      scaffoldBackgroundColor: Colors.green.shade100,
      backgroundColor: Colors.green.shade100,
    ),
    AppTheme.purpleTheme: ThemeData(
      appBarTheme: const AppBarTheme(color: Colors.purple),
      scaffoldBackgroundColor: Colors.purple.shade100,
      backgroundColor: Colors.purple.shade100,
    )
  };
}

enum AppTheme { brownTheme, greenTheme, purpleTheme }
