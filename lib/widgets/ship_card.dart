import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        leading: Icon(
          Icons.location_on,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(
          'Calcular frete',
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        trailing: Icon(
          Icons.arrow_downward,
          color: Theme.of(context).primaryColor,
        ),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(4),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Digite seu CEP'),
              initialValue: "",
              onFieldSubmitted: (text) {},
            ),
          )
        ],
      ),
    );
  }
}
