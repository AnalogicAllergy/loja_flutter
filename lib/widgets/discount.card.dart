import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_flutter/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Cupom de desconto',
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        trailing: Icon(
          Icons.arrow_downward,
          color: Theme.of(context).primaryColor,
        ),
        leading:
            Icon(Icons.card_giftcard, color: Theme.of(context).primaryColor),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(2),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Insira seu cupom'),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection('coupons')
                    .document(text)
                    .get()
                    .then((docSnap) {
                  if (docSnap.data != null) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Desconto de ${docSnap.data['percent']}% aplicado!"),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Cupom inválido"),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
