import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercefirebase/screens/editProduct.dart';
import 'package:ecommercefirebase/widgets/custom_menu.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefirebase/services/store.dart';
import 'package:ecommercefirebase/models/product.dart';
import 'package:ecommercefirebase/constants.dart';

class ManageProducts extends StatefulWidget {
  static String id = 'ManageProducts';
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<ManageProducts> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                products.add(Product(
                    pId: doc.documentID,
                    pPrice: data[kProductPrice],
                    pName: data[kProductName],
                    pDescription: data[kProductDescription],
                    pLocation: data[kProductLocation],
                    pCategory: data[kProductCategory]));
              }
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10.0),
                      child: GestureDetector(
                        onTapUp: (details) {
                          double dx = details.globalPosition.dx;
                          double dy = details.globalPosition.dy;
                          double dx2 = MediaQuery.of(context).size.width - dx;
                          double dy2 = MediaQuery.of(context).size.width - dy;
                          showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                              items: [
                                MyPopupMenuItem(
                                  child: Text('Edit'),
                                  onClick: () {
                                    Navigator.pushNamed(context, EditProduct.id,
                                        arguments: products[index]);
                                  },
                                ),
                                MyPopupMenuItem(
                                  child: Text('Delete'),
                                  onClick: () {
                                    _store.deleteProduct(products[index].pId);
                                  },
                                ),
                              ]);
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          products[index].pName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
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
            } else {
              return Text('Loading...');
            }
          }),
    );
  }
}



