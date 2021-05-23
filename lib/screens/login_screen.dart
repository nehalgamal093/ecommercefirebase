import 'package:ecommercefirebase/constants.dart';
import 'package:ecommercefirebase/provider/adminMode.dart';
import 'package:ecommercefirebase/provider/modelHud.dart';
import 'package:ecommercefirebase/screens/signup_screen.dart';
import 'package:ecommercefirebase/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefirebase/services/auth.dart';
import 'package:provider/provider.dart';
import 'admin_home.dart';
import 'home.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';
  String _email, _password;
  final _auth = Auth();
  final adminPassword = '123456';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isAdmin = false;
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
                builder: (context) => MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Colors.black,
                  onPressed: ()  {
                    _validate(context);
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Provider.of<AdminMode>(context, listen: false)
                        .changeisAdmin(true);
                  },
                  child: Text(
                    'I\m an admin',
                    style: TextStyle(
                        color: Provider.of<AdminMode>(context).isAdmin
                            ? kMainColor
                            : Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false)
                              .changeisAdmin(false);
                        },
                        child: Text(
                          'I\m a user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdminMode>(context).isAdmin
                                  ? Colors.white
                                  : kMainColor),
                        ))),
              ]),
            )
          ],
        ),
      ),
    );
  }

  void _validate(BuildContext context) async{
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    modelHud.changeisLoading(true);
    if (_globalKey.currentState.validate()) {
      _globalKey.currentState.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == adminPassword) {
          try {
           await _auth.signIn(_email, _password);
            Navigator.pushNamed(context, AdminHome.id);
          } catch (e) {
            modelHud.changeisLoading(false);
            
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message)));
          }
        } else {
           modelHud.changeisLoading(false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Something went wrong')));
        }
      } else {
        try {
         await _auth.signIn(_email, _password);
          Navigator.pushNamed(context, HomePage.id);
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
    modelHud.changeisLoading(false);
  }
}
