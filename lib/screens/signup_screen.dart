import 'package:ecommercefirebase/provider/modelHud.dart';
import 'package:ecommercefirebase/screens/login_screen.dart';
import 'package:ecommercefirebase/services/auth.dart';
import 'package:ecommercefirebase/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  final _auth = Auth();
  String _email, _password;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
        backgroundColor: kMainColor,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
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
                            style: TextStyle(
                                fontFamily: 'Pacifico', fontSize: 25.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * .1),
                CustomTextField(
                  hint: 'Enter your name',
                  icon: Icons.person,
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  hint: 'Enter your email',
                  icon: Icons.email,
                  onClick: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: height * .02),
                CustomTextField(
                  hint: 'Enter your password',
                  icon: Icons.lock,
                  onClick: (value) {
                    _password = value;
                  },
                ),
                SizedBox(height: height * .05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 120),
                  child: Builder(
                    builder: (context) => MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.black,
                      onPressed: () async {
                        final modelHud = Provider.of<ModelHud>(context,listen: false);
                        modelHud.changeisLoading(true);
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          print(_email);
                          print(_password);
                          try {
                            final authResult =
                                await _auth.signUp(_email.trim(), _password.trim());
                            modelHud.changeisLoading(false);
                            Navigator.pushNamed(context, LoginScreen.id);
                          } catch (e) {
                            modelHud.changeisLoading(false);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message)));
                          }
                        }
                        modelHud.changeisLoading(false);
                      },
                      child: Text('Sign up',
                          style: TextStyle(color: Colors.white)),
                    ),
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
          ),
        ),
      );
   
  }
}
