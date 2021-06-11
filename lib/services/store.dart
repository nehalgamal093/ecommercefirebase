import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercefirebase/constants.dart';
import 'package:ecommercefirebase/screens/addProduct.dart';
import 'package:ecommercefirebase/services/store.dart';
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

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }
   Stream<QuerySnapshot> orderDetails(documentId) {
    return _firestore.collection(kOrders).document(documentId).collection(kOrdersDetails).snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(kProductCollection).document(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore
        .collection(kProductCollection)
        .document(documentId)
        .updateData(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrders).document();
    for (var product in products) {
      documentRef.setData(data);
      documentRef.collection(kOrdersDetails).document().setData({
        kProductName: product.pName,
        kProductPrice: product.pPrice,
        kProductQuanity: product.pQuantity,
        kProductLocation: product.pLocation,
        kProductCategory:product.pCategory
      });
    }
  }
}
