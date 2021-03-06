import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercefirebase/constants.dart';
import 'package:ecommercefirebase/functions/functions.dart';
import 'package:ecommercefirebase/models/product.dart';
import 'package:ecommercefirebase/screens/login_screen.dart';
import 'package:ecommercefirebase/screens/productInfo.dart';
import 'package:ecommercefirebase/services/store.dart';
import 'package:ecommercefirebase/widgets/productView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefirebase/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cartScreen.dart';


class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = Store();
  final _auth = Auth();
  FirebaseUser _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  List<Product> _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _bottomBarIndex,
                fixedColor: kMainColor,
                onTap: (value) {
                  setState(() async {
                    if (value == 2) {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.clear();
                      await _auth.SignOut();
                      Navigator.popAndPushNamed(context, LoginScreen.id);
                    }
                    _bottomBarIndex = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Person'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), label: 'Person'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.close), label: 'Sign Out'),
                ],
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                  indicatorColor: kMainColor,
                  onTap: (value) {
                    setState(() {
                      _tabBarIndex = value;
                    });
                  },
                  tabs: <Widget>[
                    Text(
                      'Jackets',
                      style: TextStyle(
                          color:
                              _tabBarIndex == 0 ? Colors.black : kOnActiveColor,
                          fontSize: _tabBarIndex == 0 ? 16 : null),
                    ),
                    Text('Trouser',
                        style: TextStyle(
                            color: _tabBarIndex == 1
                                ? Colors.black
                                : kOnActiveColor,
                            fontSize: _tabBarIndex == 1 ? 16 : null)),
                    Text('T-shirts',
                        style: TextStyle(
                            color: _tabBarIndex == 2
                                ? Colors.black
                                : kOnActiveColor,
                            fontSize: _tabBarIndex == 2 ? 16 : null)),
                    Text('Shoes',
                        style: TextStyle(
                            color: _tabBarIndex == 3
                                ? Colors.black
                                : kOnActiveColor,
                            fontSize: _tabBarIndex == 3 ? 16 : null)),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  jacketView(),
                  productView(kTrousers, _products),
                  productView(kTshirts, _products),
                  Text('Text4'),
                ],
              )),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    getCurrentUser();
  }

  getCurrentUser() async {
    _loggedUser = await _auth.getUser();
  }

  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;

              products.add(Product(
                  pId: doc.documentID,
                  pPrice: data[kProductPrice],
                  pName: data[kProductName],
                  pDescription: data[kProductDescription],
                  pLocation: data[kProductLocation],
                  pCategory: data[kProductCategory]));
            }
            _products = [...products];
            products.clear();
            products = getProductByCategory(kJackets, _products);
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .8,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ProductInfo.id,
                            arguments: products[index]);
                      },
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image(
                              image: AssetImage(products[index].pLocation),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[index].pName,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text('\$ ${products[index].pPrice}')
                                    ],
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 60.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Text('Loading...');
          }
        });
  }
}
