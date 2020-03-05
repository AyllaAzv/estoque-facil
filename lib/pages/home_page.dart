import 'package:estoque_facil/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
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
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
            _drawerKey.currentState.openDrawer();
          },
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
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
