import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercefirebase/constants.dart';
import 'package:ecommercefirebase/services/store.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefirebase/models/product.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.orderDetails(documentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              products.add(Product(
                pName: doc.data[kProductName],
                pQuantity: doc.data[kProductQuanity],
                pCategory: doc.data[kProductCategory]
              ));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context,index)=>Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                                  height: MediaQuery.of(context).size.height * .2,
                                  color: KSecondaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text('product name: ${products[index].pName}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Quantity:${products[index].pQuantity}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                         Text(
                                          'Category:${products[index].pCategory}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                    ),
                  ),
                ),
                Padding(
                   padding:EdgeInsets.symmetric(horizontal:20),
                child:Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ButtonTheme(
                        child: MaterialButton(
                          color:kMainColor,
                          child:Text('Confirm Order'),
                          onPressed: (){}),
                      ),
                    ),
                    SizedBox(width:10,),
                    Expanded(
                      child: ButtonTheme(

                      child:MaterialButton(
                        color:kMainColor,
                        child:Text('Delete Order'),
                        onPressed:(){})),
                    ),
                  ],
                ))
              ],
            );
          } else {
            return Center(child: Text('Loading Order Details'));
          }
        },
      ),
    );
  }
}
