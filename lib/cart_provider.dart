import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_model.dart';
import 'db_helper.dart';

class CartProvider with ChangeNotifier {
  DBHelper db = DBHelper();
  int _counter = 0;
  int get counter => _counter;
  int _cartcounter = 0;
  int get cartcounter => _cartcounter;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;
  Future<List<Cart>> getdata() async {
    _cart = db.getCartList();
    return _cart;
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    prefs.setInt('cart counter', _cartcounter);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    _totalPrice = prefs.getDouble('total_price') ?? 0.0;
    _cartcounter = prefs.getInt('cart counter') ?? 0;
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void addcartcounter() {
    _cartcounter = cartcounter + 1;
    _setPrefItems();
    notifyListeners();
  }

  void removecartcountr() {
    _cartcounter = _cartcounter - 1;
    print(_cartcounter);
    print(_cartcounter);
    _setPrefItems();
    notifyListeners();
  }

  int getcartcounter() {
    _getPrefItems();
    return _cartcounter;
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }
}
