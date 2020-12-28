import 'package:buy_it_store/common/constants.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  static const routeName = 'admin-home-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Center(
            child: GridView.builder(
              itemCount: Constants.adminBoard.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Constants.adminBoard[index]['nav']);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Constants.kMainColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      Constants.adminBoard[index]['title'],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
          ),
        )

        /* Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomBottom(
              ctx: context,
              bTitle: "Add Product",
              bNavigator: AddProductScreen.routeName,
            ),
            CustomBottom(
              ctx: context,
              bTitle: "View Products",
              bNavigator: PreviewProductsScreen.routeName,
            ),
            CustomBottom(
              ctx: context,
              bTitle: "Orders",
              bNavigator: OrdersScreen.routeName,
            )
          ],
        ),
      ), */
        );
  }
}
