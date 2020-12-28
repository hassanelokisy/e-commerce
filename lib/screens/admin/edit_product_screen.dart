import 'dart:io';

import 'package:buy_it_store/common/size_constants.dart';
import 'package:buy_it_store/functions/image_pickerr.dart';
import 'package:buy_it_store/models/product_model.dart';
import 'package:buy_it_store/provider/store.dart';
import 'package:buy_it_store/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = 'edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _editGlobalKey = GlobalKey<FormState>();
    Product product = ModalRoute.of(context).settings.arguments;
    TextEditingController _name = TextEditingController();
    TextEditingController _price = TextEditingController();
    TextEditingController _describtion = TextEditingController();
    TextEditingController _category = TextEditingController();
    String imageUrl;
    File _image;

    Future<bool> setTextEditing() async {
      _name.text = product.pName;
      _price.text = product.pPrice;
      _describtion.text = product.pDescription;
      _category.text = product.pCategory;
      imageUrl = product.pImageUrl;
      return true;
    }

    return Scaffold(
      body: FutureBuilder(
        future: setTextEditing(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading...'));
          }
          if (snapshot.hasData) {
            return Form(
              key: _editGlobalKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: Sizes.dimen_100.h,
                  ),
                  CustomTextField(
                    hint: "Product Name",
                    controller: _name,
                  ),
                  SizedBox(
                    height: Sizes.dimen_10.h,
                  ),
                  CustomTextField(
                    hint: "Product price",
                    controller: _price,
                  ),
                  SizedBox(
                    height: Sizes.dimen_10.h,
                  ),
                  CustomTextField(
                    hint: "Product description",
                    controller: _describtion,
                  ),
                  SizedBox(
                    height: Sizes.dimen_10.h,
                  ),
                  CustomTextField(
                    hint: "Product category",
                    controller: _category,
                  ),
                  SizedBox(
                    height: Sizes.dimen_20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_80.w),
                    child: RaisedButton(
                      child: Text("Edit Product"),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_editGlobalKey.currentState.validate()) {
                          _editGlobalKey.currentState.save();
                          await Provider.of<Store>(context, listen: false)
                              .editProduct(
                            product: Product(
                              pName: _name.text,
                              pPrice: _price.text,
                              pCategory: _category.text,
                              pDescription: _describtion.text,
                              pId: product.pId,
                              pImageUrl: product.pImageUrl,
                            ),
                           
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Sizes.dimen_20.h,
                  ),
                  GestureDetector(
                    onLongPress: () {
                      _showImage2(imageurl: imageUrl);
                    },
                    child: Image.network(
                      imageUrl,
                      width: Sizes.dimen_150.w,
                      height: Sizes.dimen_150.h,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  void _showImage({file}) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          elevation: 15,
          backgroundColor: Colors.blue,
          contentPadding: EdgeInsets.all(Sizes.dimen_0.h),
          content: Image.file(file),
        );
      },
    );
  }

  void _showImage2({imageurl}) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (ctx) {
        return AlertDialog(
          elevation: 15,
          backgroundColor: Colors.blue,
          contentPadding: EdgeInsets.all(Sizes.dimen_0.h),
          content: Image.network(imageurl),
        );
      },
    );
  }
}
