import 'package:flutter/material.dart';
import 'package:loja_flutter/tabs/home_tab.dart';
import 'package:loja_flutter/tabs/order_tabs.dart';
import 'package:loja_flutter/tabs/places_tab.dart';
import 'package:loja_flutter/tabs/products_tab.dart';
import 'package:loja_flutter/widgets/cart_button.dart';
import 'package:loja_flutter/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      //impede que as paginas sejam arrastadas para mudar o contexto
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),

      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        //lojas
        Scaffold(
          appBar: AppBar(
            title: Text('Lojas'),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Meus pedidos'),
            centerTitle: true,
          ),
          body: OrderTabs(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
