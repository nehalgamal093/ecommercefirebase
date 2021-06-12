import 'package:ecommercefirebase/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefirebase/services/store.dart';
import 'package:ecommercefirebase/models/product.dart';

class AddProduct extends StatelessWidget {
  String _name, _price, _description, _category, _imageLocation;
  static String id = 'AddProduct';
  final _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              hint: 'Product Name',
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(height: 10.0),
            CustomTextField(
              hint: 'Product Price',
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(height: 10.0),
            CustomTextField(
              hint: 'Product Description',
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(height: 10.0),
            CustomTextField(
              hint: 'Product Category',
              onClick: (value) {
                _category = value;
              },
            ),
            SizedBox(height: 10.0),
            CustomTextField(
              hint: 'Product Location',
              onClick: (value) {
                _imageLocation = value;
              },
            ),
            SizedBox(height: 10.0),
            MaterialButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _globalKey.currentState.save();
                  _store.addProduct(Product(
                      pName: _name,
                      pPrice: _price,
                      pCategory: _category,
                      pDescription: _description,
                      pLocation: _imageLocation));
                }
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}
