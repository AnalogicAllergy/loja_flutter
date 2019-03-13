import 'package:flutter/material.dart';
import 'package:loja_flutter/tabs/home_tab.dart';
import 'package:loja_flutter/tabs/products_tab.dart';
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
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
        Container(
          color: Colors.pink,
        ),
      ],
    );
  }
}
