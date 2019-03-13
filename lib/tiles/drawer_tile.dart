import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.iconData, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: <Widget>[
              Icon(
                iconData,
                size: 32,
                color: pageController.page.round() == page
                    ? Colors.blueGrey
                    : Colors.black,
              ),
              SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: pageController.page.round() == page
                      ? Colors.blueGrey
                      : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
