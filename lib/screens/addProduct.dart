import 'package:ecommercefirebase/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  String _name, _price, _description, _category,_imageLocation;
  static String id = 'AddProduct';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(hint: 'Product Name'),
          SizedBox(height: 10.0),
          CustomTextField(hint: 'Product Price'),
          SizedBox(height: 10.0),
          CustomTextField(hint: 'Product Description'),
          SizedBox(height: 10.0),
          CustomTextField(hint: 'Product Category'),
          SizedBox(height: 10.0),
          CustomTextField(hint: 'Product Location'),
          SizedBox(height: 10.0),
          MaterialButton(
            onPressed: () {},
            child: Text('Add Product'),
          )
        ],
      ),
    );
  }
}
