import 'package:buy_it_store/common/constants.dart';
import 'package:buy_it_store/models/product_model.dart';
import 'package:buy_it_store/provider/store.dart';
import 'package:buy_it_store/screens/admin/edit_product_screen.dart';
import 'package:buy_it_store/widgets/admin/custom_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PreviewProductsScreen extends StatelessWidget {
  static const String routeName = 'preview-products';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kMainColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<Store>(context).loadProducts(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading...'));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error try later'));
          }
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              products.add(Product(
                  pId: doc.id,
                  pPrice: data[Constants.kProductPrice],
                  pName: data[Constants.kProductName],
                  pDescription: data[Constants.kProductDescription],
                  pImageUrl: data[Constants.kProductLocation],
                  pCategory: data[Constants.kProductCategory]));
            }
            return GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTapUp: (onTapUp) async {
                      double dx = onTapUp.globalPosition.dx;
                      double dy = onTapUp.globalPosition.dy;
                      double dx2 = ScreenUtil().screenHeight - dx;
                      double dy2 = ScreenUtil().screenWidth - dy;
                      await showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                          semanticLabel: "hgfghgg",
                          color: Colors.red,
                          elevation: 15,
                          items: [
                            MyPopupMenuItem(
                              onClick: () {
                                Navigator.pushNamed(
                                  context,
                                  EditProductScreen.routeName,
                                  arguments: products[index],
                                );
                              },
                              child: Text('Edit'),
                            ),
                            MyPopupMenuItem(
                              onClick: () async {
                                await Provider.of<Store>(context, listen: false)
                                    .deleteProduct(
                                  products[index].pId,
                                  products[index].pImageUrl,
                                );
                                Navigator.of(context).pop();
                              },
                              child: Text('Delete'),
                            ),
                          ]);
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Image(
                            fit: BoxFit.fill,
                            image: NetworkImage(products[index].pImageUrl),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Opacity(
                            opacity: .6,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      products[index].pName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('\$ ${products[index].pPrice}')
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
