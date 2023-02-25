import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/cart_provider.dart';
import 'package:shoppingcart/productlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CartProvider(),
        child: Builder(builder: (BuildContext context) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(),
              home: const ProductListscreen());
        }));
  }
}
