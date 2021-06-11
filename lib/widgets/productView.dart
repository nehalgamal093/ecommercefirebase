import 'package:ecommercefirebase/functions/functions.dart';
import 'package:ecommercefirebase/screens/models/product.dart';
import 'package:flutter/material.dart';
import'package:ecommercefirebase/screens/productInfo.dart';

Widget productView(String pCategory,List<Product>allProducts) {
  List<Product> products;
  products = getProductByCategory(pCategory,allProducts);
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
          child: GestureDetector(
            onTap:(){
              Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image(
                    image: AssetImage(products[index].pLocation),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: .6,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].pName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('\$ ${products[index].pPrice}')
                          ],
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}
