import 'package:buy_it_store/common/constants.dart';
import 'package:buy_it_store/functions/admin/functions.dart';
import 'package:buy_it_store/models/product_model.dart';
import 'package:buy_it_store/provider/store.dart';
import 'package:buy_it_store/screens/user/productInfo.dart';
import 'package:buy_it_store/widgets/user/productView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  static const String routeName = 'user-home-screen';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _tabBarIndex = 0;
  List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.kUnActiveColor,
          title: Text("DISCOVER"),
          bottom: TabBar(
            indicatorColor: Constants.kMainColor,
            onTap: (value) {
              setState(() {
                _tabBarIndex = value;
              });
              print(_tabBarIndex);
            },
            tabs: [
              buildTab(
                title: 'Jackets',
                iconData: Icons.access_alarm,
                index: 0,
              ),
              buildTab(
                title: 'Pants',
                iconData: Icons.access_alarm,
                index: 1,
              ),
              buildTab(
                title: 'T-shirts',
                iconData: Icons.access_alarm,
                index: 2,
              ),
              buildTab(
                title: 'Shoes',
                iconData: Icons.access_alarm,
                index: 3,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            jacketView(),
            ProductsView(Constants.kTrousers, _products),
            ProductsView(Constants.kShoes, _products),
            ProductsView(Constants.kTshirts, _products),
          ],
        ),
      ),
    );
  }

  Widget buildTab({String title, int index, IconData iconData}) {
    return Tab(
      child: Text(
        title,
        style: TextStyle(
          color:
              _tabBarIndex == index ? Colors.black : Constants.kSecondaryColor,
          fontSize: _tabBarIndex == index ? 16 : null,
        ),
      ),
      icon: Icon(
        iconData,
        color: _tabBarIndex == index ? Colors.black : Constants.kSecondaryColor,
      ),
    );
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<Store>(context).loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          print(snapshot.data.docs.length);
          for (var doc in snapshot.data.docs) {
            print(snapshot.data.docs);
            var data = doc.data();
            products.add(Product(
                pId: doc.documentID,
                pPrice: data[Constants.kProductPrice],
                pName: data[Constants.kProductName],
                pDescription: data[Constants.kProductDescription],
                pImageUrl: data[Constants.kProductLocation],
                pCategory: data[Constants.kProductCategory]));
          }
          _products = [...products];
          products.clear();
          products = getProductsByCategory('j', _products);
          print(products);
          print('*****');
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  
                  Navigator.pushNamed(context, ProductInfo.routeName,
                      arguments: products[index]);
               
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
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
            ),
            itemCount: products.length,
          );
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }
}
