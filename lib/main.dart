import 'package:ecommercefirebase/provider/adminMode.dart';
import 'package:ecommercefirebase/provider/modelHud.dart';
import 'package:ecommercefirebase/screens/addProduct.dart';
import 'package:ecommercefirebase/screens/admin_home.dart';
import 'package:ecommercefirebase/screens/home.dart';
import 'package:ecommercefirebase/screens/login_screen.dart';
import 'package:ecommercefirebase/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(create: (context)=>ModelHud()),
        ChangeNotifierProvider<AdminMode>(create: (context)=>AdminMode()),
      ],
      child: MaterialApp(
          initialRoute: LoginScreen.id,
          routes:{
            LoginScreen.id:(context)=> LoginScreen(),
            SignupScreen.id:(context)=> SignupScreen(),
            HomePage.id:(context)=> HomePage(),
            AdminHome.id:(context)=>AdminHome(),
            AddProduct.id:(context)=>AddProduct()
          }
       
      ),
    );
  }
}