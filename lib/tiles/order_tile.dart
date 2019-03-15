import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;
  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('orders')
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Codigo do pedido ${snapshot.data.documentID}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    height: 4,
                  ),
                  Text(_buildProductsText(snapshot.data)),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String texto = "Descricao: \n";
    for (LinkedHashMap t in snapshot.data["products"]) {
      texto +=
          "${t['quantity']} x${t['product']['title']} (R\$ ${t['product']['price'].toStringAsFixed(2)})\n";
    }
    texto += "Total: R\$ ${snapshot.data['totalPrice'].toStringAsFixed(2)}";
    return texto;
  }
}
