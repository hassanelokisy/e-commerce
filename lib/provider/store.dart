import 'dart:io';

import 'package:buy_it_store/common/constants.dart';
import 'package:buy_it_store/functions/get_random_string.dart';
import 'package:buy_it_store/models/product_model.dart';
import 'package:buy_it_store/provider/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class Store extends ChangeNotifier {
  var _firestore = FirebaseFirestore.instance;
  var _firestorage = FirebaseStorage.instance;
  Auth auth = Auth();

  addProduct({Product product, File image}) async {
    try {
      User user = await auth.getUser();
      String str = getRandomString(10);
      var ref =
          await _firestorage.ref().child("products-images").child(str + '.jpg');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      print(url);
      print(product.pName);
      print('--------');
      print(product);

      await _firestore.collection(Constants.kProductsCollection).add({
        Constants.kProductName: product.pName,
        Constants.kProductDescription: product.pDescription,
        Constants.kProductLocation: url,
        Constants.kProductCategory: product.pCategory,
        Constants.kProductPrice: product.pPrice,
      });
    } catch (e) {
      print("fdsfdsdfsfds" + e);
    }
  }

  editProduct({Product product}) async {
    try {
      await _firestore
          .collection(Constants.kProductsCollection)
          .doc(product.pId)
          .update({
        Constants.kProductName: product.pName,
        Constants.kProductDescription: product.pDescription,
        Constants.kProductLocation: product.pImageUrl,
        Constants.kProductCategory: product.pCategory,
        Constants.kProductPrice: product.pPrice,
      });
    } catch (e) {
      print('Something went wrong while editing the product');
    }
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(Constants.kProductsCollection).snapshots();
  }

  deleteProduct(id, imgUrl) async {
    try {
      await _firestorage.refFromURL(imgUrl).delete();
      await _firestore
          .collection(Constants.kProductsCollection)
          .doc(id)
          .delete();
    } catch (e) {
      throw ErrorHint("something went wrong white deleting the product");
    }
  }

  
}
