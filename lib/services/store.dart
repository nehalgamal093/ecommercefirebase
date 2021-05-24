import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercefirebase/constants.dart';
import 'package:ecommercefirebase/screens/addProduct.dart';

import '../screens/models/product.dart';

class Store {
  final Firestore _firestore = Firestore.instance;
  addProduct(Product product) {
    _firestore.collection(kProductCollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductCategory: product.pCategory,
      kProductDescription: product.pDescription,
      kProductLocation: product.pLocation
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductCollection).snapshots();
  }
}
