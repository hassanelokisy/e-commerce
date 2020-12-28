import 'dart:io';

import 'package:buy_it_store/common/size_constants.dart';
import 'package:buy_it_store/functions/image_pickerr.dart';
import 'package:buy_it_store/models/product_model.dart';
import 'package:buy_it_store/provider/store.dart';
import 'package:buy_it_store/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = 'add-product';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  Map<String, String> productData = {
    'name': '',
    'price': '',
    'description': '',
    'category': '',
  };



  File _image;

  Product _product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              SizedBox(
                height: Sizes.dimen_100.h,
              ),
              CustomTextField(
                hint: "Product Name",
                onClick: (value) {
                  productData['name'] = value;
                },
              ),
              SizedBox(
                height: Sizes.dimen_10.h,
              ),
              CustomTextField(
                hint: "Product price",
                onClick: (value) {
                  productData['price'] = value;
                },
              ),
              SizedBox(
                height: Sizes.dimen_10.h,
              ),
              CustomTextField(
                hint: "Product description",
                onClick: (value) {
                  productData['description'] = value;
                },
              ),
              SizedBox(
                height: Sizes.dimen_10.h,
              ),
              CustomTextField(
                hint: "Product category",
                onClick: (value) {
                  productData['category'] = value;
                },
              ),
              SizedBox(
                height: Sizes.dimen_20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_50.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text("choose Image"),
                      onPressed: () async {
                        _image = await pickAnImage();
                        FocusScope.of(context).unfocus();
                        setState(() {});
                      },
                    ),
                    RaisedButton(
                      child: Text("Add Product"),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          await Provider.of<Store>(context, listen: false)
                              .addProduct(
                            product: Product(
                              pName: productData['name'],
                              pPrice: productData['price'],
                              pCategory: productData['category'],
                              pDescription: productData['description'],
                            ),
                            image: _image,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Sizes.dimen_20.h,
              ),
              SizedBox(
                height: Sizes.dimen_150.h,
                width: Sizes.dimen_150.w,
                child: _image == null
                    ? Container()
                    : GestureDetector(
                        onLongPress: () {
                          FocusScope.of(context).unfocus();
                          if (_image != null) {
                            _showImage(file: _image);
                          }
                        },
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ],
          ),
        ),
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
}
