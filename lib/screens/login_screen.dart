import 'package:ecommercefirebase/constants.dart';
import 'package:ecommercefirebase/screens/signup_screen.dart';
import 'package:ecommercefirebase/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefirebase/services/auth.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String _email, _password;
  final _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Form(
        key: _globalKey,
        child: ListView(
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
            CustomTextField(
              onClick: (value) {
                _email = value;
              },
              hint: 'Enter your email',
              icon: Icons.email,
            ),
            SizedBox(height: height * .02),
            CustomTextField(
              onClick: (value) {
                _password = value;
              },
              hint: 'Enter your password',
              icon: Icons.lock,
            ),
            SizedBox(height: height * .05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: Builder(
               builder:(context)=> MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.black,
                  onPressed: () async {
                    if (_globalKey.currentState.validate()) {
                      try{
                      _globalKey.currentState.save();
                      print(_email);
                      print(_password);
                      final authResult = await _auth.signIn(_email, _password);
                      print(authResult.user.uid);}
                      catch(e){
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar
                          (
                            content: Text(e.message)
                          ));
                      }
                    }
                  },
                  child: Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(height: height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an Account ? ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignupScreen.id);
                  },
                  child: Text('Signup',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
