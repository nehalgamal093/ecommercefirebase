import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercefirebase/constants.dart';
import 'package:ecommercefirebase/screens/orderDetails.dart';
import 'package:ecommercefirebase/services/store.dart';
import 'package:flutter/material.dart';
import 'package:ecommercefirebase/models/order.dart';

class OrderScreen extends StatelessWidget {
  static String id = 'OrderScreen';
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: _store.loadOrders(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('There is no orders'),
          );
        } else {
          List<Order> orders = [];
          for (var doc in snapshot.data.documents) {
            orders.add(Order(
              documentId: doc.documentID,
                totalPrice: doc.data[kTotalPrice],
                Address: doc.data[kAddress]));
          }
          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context,OrderDetails.id,arguments: orders[index].documentId);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      color: KSecondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Total Price = \$ ${orders[index].totalPrice}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Address is : ${orders[index].Address}',
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
                );
              });
        }
      },
    ));
  }
}
