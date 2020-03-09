import 'package:estoque_facil/pages/produto_form.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:estoque_facil/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class ProdutosPage extends StatefulWidget {
  @override
  _ProdutosPageState createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage>
    with SingleTickerProviderStateMixin<ProdutosPage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFececec),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Produtos",
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Text(
                "Disponível",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "Acabando",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Tab(
              child: Text(
                "Sem estoque",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          push(context, ProdutoFormPage());
        },
      ),
      body: _body(),
    );
  }

  _body() {
    return TabBarView(
      controller: _tabController,
      children: <Widget>[
        Container(),
        Container(),
        Container(),
      ],
    );
  }
}
