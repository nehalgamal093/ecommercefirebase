import 'package:ecommercefirebase/screens/login_screen.dart';
import 'package:ecommercefirebase/screens/signup_screen.dart';
import 'package:flutter/material.dart';

main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes:{
        LoginScreen.id:(context)=> LoginScreen(),
        SignupScreen.id:(context)=> SignupScreen()
      }
    );
  }
}