import 'package:ecommercefirebase/constants.dart';
import 'package:ecommercefirebase/provider/adminMode.dart';
import 'package:ecommercefirebase/provider/cartItem.dart';
import 'package:ecommercefirebase/provider/modelHud.dart';
import 'package:ecommercefirebase/screens/addProduct.dart';
import 'package:ecommercefirebase/screens/admin_home.dart';
import 'package:ecommercefirebase/screens/cartScreen.dart';
import 'package:ecommercefirebase/screens/editProduct.dart';
import 'package:ecommercefirebase/screens/login_screen.dart';
import 'package:ecommercefirebase/screens/manageProduct.dart';
import 'package:ecommercefirebase/screens/home.dart';
import 'package:ecommercefirebase/screens/orderDetails.dart';
import 'package:ecommercefirebase/screens/orderScreen.dart';
import 'package:ecommercefirebase/screens/productInfo.dart';
import 'package:ecommercefirebase/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              home: Scaffold(
                  body: Center(
                child: Text('Loading'),
              )),
            );
          } else {
            isUserLoggedIn = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ModelHud>(
                    create: (context) => ModelHud()),
                ChangeNotifierProvider<AdminMode>(
                    create: (context) => AdminMode()),
                ChangeNotifierProvider<CartItem>(
                    create: (context) => CartItem()),
              ],
              child: MaterialApp(
                initialRoute:isUserLoggedIn ?HomePage.id : LoginScreen.id,
                routes: {
                  LoginScreen.id: (context) => LoginScreen(),
                  SignupScreen.id: (context) => SignupScreen(),
                  HomePage.id: (context) => HomePage(),
                  AdminHome.id: (context) => AdminHome(),
                  AddProduct.id: (context) => AddProduct(),
                  ManageProducts.id: (context) => ManageProducts(),
                  EditProduct.id: (context) => EditProduct(),
                  ProductInfo.id: (context) => ProductInfo(),
                  CartScreen.id: (context) => CartScreen(),
                  OrderScreen.id: (context) => OrderScreen(),
                  OrderDetails.id: (context) => OrderDetails()
                },
                debugShowCheckedModeBanner: false,
              ),
            );
          }
        });
  }
}
