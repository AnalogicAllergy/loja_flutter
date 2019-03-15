import 'package:flutter/material.dart';
import 'package:loja_flutter/models/cart_model.dart';
import 'package:loja_flutter/models/user_model.dart';
import 'package:loja_flutter/screens/login_screen.dart';
import 'package:loja_flutter/screens/order_screen.dart';
import 'package:loja_flutter/tiles/cart_tile.dart';
import 'package:loja_flutter/widgets/cart_price.dart';
import 'package:loja_flutter/widgets/discount.card.dart';
import 'package:loja_flutter/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
        centerTitle: true,
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int quantidade = model.products.length;
                return Text(
                  "${quantidade ?? 0} ${quantidade == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 16),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Faça login para adicionar produtos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                  )
                ],
              ),
            );
          } else if (model.products == null || model.products.length == 0) {
            return Center(
              child: Text(
                'Nenhum produto no carrinho',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                    children: model.products.map((product) {
                  return CartTile(product);
                }).toList()),
                DiscountCard(),
                ShipCard(),
                CartPrice(() async {
                  String orderID = await model.finishOrder();
                  if (orderID != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OrderScreen(orderID)));
                  }
                }),
              ],
            );
          }
        },
      ),
    );
  }
}
