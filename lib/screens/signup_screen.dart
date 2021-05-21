import 'package:ecommercefirebase/screens/login_screen.dart';
import 'package:ecommercefirebase/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SignupScreen extends StatelessWidget {
  static String id = 'SignupScreen';
  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
      return Scaffold(
        backgroundColor: kMainColor,
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/icons/buyicon.png'),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Text(
                        'Buy it',
                        style:
                            TextStyle(fontFamily: 'Pacifico', fontSize: 25.0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: height * .1),
            CustomTextField(hint: 'Enter your Name', icon: Icons.person),
            SizedBox(height: height * .02),
            CustomTextField(
              hint: 'Enter your email',
              icon: Icons.email,
            ),
            SizedBox(height: height * .02),
            CustomTextField(
              hint: 'Enter your password',
              icon: Icons.lock,
            ),
            SizedBox(height: height * .05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Colors.black,
                onPressed: () {},
                child: Text('Sign up', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an Account ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text('Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                )
              ],
            )
          ],
        ),
        );
  }
}
