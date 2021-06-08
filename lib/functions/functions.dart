 import 'package:ecommercefirebase/screens/models/product.dart';

List<Product> getProductByCategory(String kJackets,List<Product>allProducts) {
    List<Product> products = [];
    for (var product in allProducts) {
      if (product.pCategory == kJackets) {
        products.add(product);
      }
    }
    return products;
  }