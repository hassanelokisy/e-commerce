import 'package:buy_it_store/models/product_model.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier {
  List<Product> _products = [];

  get products => [..._products];

  addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  deleteProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }
}
