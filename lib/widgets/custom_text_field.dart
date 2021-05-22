import 'package:flutter/material.dart';
import 'package:ecommercefirebase/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  String _errorMessage(String str) {
    switch (hint) {
      case 'Enter your name':
        return 'Name is empty!';

      case 'Enter your email':
        return 'Email is empty!';

      case 'Enter your password':
        return 'Password is empty!';
    }
  }

  CustomTextField({@required this.hint, @required this.icon,@required this.onClick});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return _errorMessage(hint);
          }
        },
        onSaved: onClick,
        obscureText: hint == "Enter your password" ? true : false,
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
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
