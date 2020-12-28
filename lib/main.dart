import 'package:buy_it_store/provider/admin_mode.dart';
import 'package:buy_it_store/provider/cart_item.dart';
import 'package:buy_it_store/provider/model_Hud.dart';
import 'package:buy_it_store/provider/store.dart';
import 'package:buy_it_store/screens/admin/add_product_screen.dart';
import 'package:buy_it_store/screens/admin/admin_home_screen.dart';
import 'package:buy_it_store/screens/admin/edit_product_screen.dart';
import 'package:buy_it_store/screens/admin/order_details_screen.dart';
import 'package:buy_it_store/screens/admin/orders_screen.dart';
import 'package:buy_it_store/screens/admin/preview_products_screen.dart';
import 'package:buy_it_store/screens/login_screen.dart';
import 'package:buy_it_store/screens/user/productInfo.dart';
import 'package:buy_it_store/screens/user/user_home_screen.dart';
import 'package:buy_it_store/provider/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App()
      /* DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => App(), // Wrap your app
  ), */
      );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHub>(create: (ctx) => ModelHub()),
        ChangeNotifierProvider<Auth>(create: (ctx) => Auth()),
        ChangeNotifierProvider<AdminMode>(create: (ctx) => AdminMode()),
        ChangeNotifierProvider<Store>(create: (ctx) => Store()),
        ChangeNotifierProvider<CartItem>(create: (ctx) => CartItem()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Buy-it Store",
        /* locale: DevicePreview.locale(context), // Add the locale here
        builder: DevicePreview.appBuilder,  */
        initialRoute: LoginScreen.routeName,
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          AdminHomeScreen.routeName: (ctx) => AdminHomeScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          OrderDetailsScreen.routeName: (ctx) => OrderDetailsScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          PreviewProductsScreen.routeName: (ctx) => PreviewProductsScreen(),
          UserHomeScreen.routeName: (ctx) => UserHomeScreen(),
          ProductInfo.routeName:(ctx) => ProductInfo(),
        },
      ),
    );
  }
}
