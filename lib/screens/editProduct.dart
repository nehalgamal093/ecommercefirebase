import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefirebase/services/store.dart';
import 'models/product.dart';
import 'package:ecommercefirebase/constants.dart';

class EditProduct extends StatefulWidget {
  static String id = 'EditProduct';
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
                                    print('Edit clicked');
                                  },
                                ),
                                MyPopupMenuItem(
                                  child: Text('Delete'),
                                  onClick: () {
                                    print('Delete clicked');
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

class MyPopupMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;
  MyPopupMenuItem({@required this.child, @required this.onClick})
      : super(child: child);
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState();
  }
}

class MyPopupMenuItemState<T, PopMenuItem>
    extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
    Navigator.pop(context);
  }
}
