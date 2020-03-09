import 'package:estoque_facil/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
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
        title: Image.asset(
          'assets/images/logo_estoque.png',
          height: 50,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {},
          ),
        ],
        iconTheme: IconThemeData(
          color: Colors.black,
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
      body: _body(),
      drawerEdgeDragWidth: 0, // THIS WAY IT WILL NOT OPEN
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Ler Código"),
        icon: Icon(Icons.chrome_reader_mode),
      ),
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
