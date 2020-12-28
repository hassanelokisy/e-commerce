import 'package:buy_it_store/screens/admin/add_product_screen.dart';
import 'package:buy_it_store/screens/admin/orders_screen.dart';
import 'package:buy_it_store/screens/admin/preview_products_screen.dart';
import 'package:flutter/material.dart';

class Constants {
  static const kMainColor = Color(0xFFFFC12F);
  static const kSecondaryColor = Color(0xFFFFE6AC);
  static const kUnActiveColor = Color(0xFFC1BDB8);
  static const kProductName = 'productName';
  static const kProductPrice = 'productPrice';
  static const kProductDescription = 'productDescription';
  static const kProductLocation = 'productLocation';
  static const kProductCategory = 'productCategory';
  static const kProductsCollection = 'Products';
  static const kJackets = 'j';
  static const kTrousers = 'p';
  static const kTshirts = 't';
  static const kShoes = 's';
  static const kOrders = 'Orders';
  static const kOrderDetails = 'OrderDetails';
  static const kTotallPrice = 'TotallPrice';
  static const kAddress = 'Address';
  static const kProductQuantity = 'Quantity';
  static const kKeepMeLoggedIn = 'KeepMeLoggedIn';

  static const List<Map<String, Object>> adminBoard = [
    {
      'title': "Add Product",
      'nav' : AddProductScreen.routeName ,
    },
    {
      'title': "View Products",
      'nav' : PreviewProductsScreen.routeName ,
    },
    {
      'title': "Orders",
      'nav' :  OrdersScreen.routeName ,
    },
  ];
}

class HintConstants {
  static const String name = "Enter your name";
  static const String email = "Enter your email";
  static const String password = "Enter your password";
}
