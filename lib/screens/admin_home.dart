import 'package:ecommercefirebase/screens/addProduct.dart';
import 'package:ecommercefirebase/screens/manageProduct.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddProduct.id);
                },
                child: Text('Add Product')),
            MaterialButton(onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            }, child: Text('Edit Product')),
            MaterialButton(onPressed: () {}, child: Text('View orders')),
          ],
        ));
  }
}
