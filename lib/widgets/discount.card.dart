import 'package:flutter/material.dart';

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
            ),
          )
        ],
      ),
    );
  }
}
