import 'package:estoque_facil/pages/home_page.dart';
import 'package:estoque_facil/pages/produtos_page.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 90,
              color: Color(0xFF102d3d),
              padding: EdgeInsets.all(15),
              child: Center(
                child: Image.asset("assets/images/logo.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                pop(context);
                push(context, HomePage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("Produtos"),
              onTap: () {
                pop(context);
                push(context, ProdutosPage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () {
                pop(context);
                push(context, HomePage(), replace: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
