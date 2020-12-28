import 'package:buy_it_store/models/product_model.dart';

List<Product> getProductsByCategory(String category, List<Product> products) {
  List<Product> _products = [];
  try {
    for (var product in products) {
      if (product.pCategory == category) {
        _products.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }

  return _products;
}
