import 'package:flutter/material.dart';
import 'package:ecommercefirebase/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  CustomTextField({@required this.hint, @required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'value is empty';
          }
          return '';
        },
        cursorColor: kMainColor,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          hintText: hint,
          filled: true,
          fillColor: KSecondaryColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
