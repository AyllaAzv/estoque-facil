import 'package:estoque_facil/model/Produto.dart';
import 'package:estoque_facil/pages/produto_form.dart';
import 'package:estoque_facil/pages/produto_page.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:estoque_facil/widgets/app_text.dart';
import 'package:estoque_facil/widgets/drawer_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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
          _menu(),
        ],
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: _body(),
      drawer: DrawerList(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _darBaixa,
        label: Text("Ler Código"),
        icon: Icon(Icons.chrome_reader_mode),
      ),
    );
  }

  _body() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _produtos().length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.5),
      ),
      itemBuilder: (context, index) {
        return _itemView(_produtos(), index);
      },
    );
  }

  _itemView(List<Produto> produtos, int index) {
    Produto p = produtos[index];
    var f = NumberFormat.currency(
        customPattern: "#,###.0##", locale: "pt_BR", decimalDigits: 2);

    return GestureDetector(
      onTap: () {
        push(context, ProdutoPage(p));
      },
      child: Card(
        color: Colors.grey[100],
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: _img(p.imagem),
              ),
              SizedBox(height: 5),
              Text(
                p.nome,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                "Cod: ${p.codigo}",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              Text("R\$ ${f.format(p.valor).toString()}")
            ],
          ),
        ),
      ),
    );
  }

  _darBaixa() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(
              "Código escaneado: 7287122173",
            ),
            content: AppText(
              "Quantidade",
              "Digite a quantidade",
              icon: Icon(Icons.confirmation_number),
              keyboardType: TextInputType.number,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);

                  print("cancelar");
                },
              ),
              FlatButton(
                child: Text("Dar baixa"),
                onPressed: () {
                  Navigator.pop(context);

                  print("Dar baixa");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _img(String img) {
    return Image.asset(
      img,
      height: 150
    );
  }

  _menu() {
    return PopupMenuButton<String>(
      onSelected: (String valor) => _onClickPopUpMenu(valor),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: "Cadastrar",
            child: Text(
              "Cadastrar Produto",
            ),
          ),
        ];
      },
    );
  }

  _onClickPopUpMenu(String valor) {
    switch (valor) {
      case "Cadastrar":
        push(context, ProdutoFormPage());
        break;
    }
  }

  _produtos() {
    List<Produto> produtos = [
      Produto(
        id: 1,
        nome: "Galaxy A20",
        imagem: "assets/images/a20.png",
        valor: 800.56,
        quantidade: 4,
        quantidadeMinima: 2,
        quantidadeMaxima: 10,
        codigo: "123456",
      ),
      Produto(
          id: 1,
          nome: "Asus Max Pro",
          imagem: "assets/images/asus-max-pro.png",
          valor: 800.0,
          quantidade: 4,
          quantidadeMinima: 2,
          quantidadeMaxima: 10,
          codigo: "123456"),
      Produto(
          id: 1,
          nome: "Iphone 8",
          imagem: "assets/images/iphone-8.png",
          valor: 800.0,
          quantidade: 4,
          quantidadeMinima: 2,
          quantidadeMaxima: 10,
          codigo: "123456"),
      Produto(
          id: 1,
          nome: "Iphone 11",
          imagem: "assets/images/Iphone-11.png",
          valor: 800.0,
          quantidade: 4,
          quantidadeMinima: 2,
          quantidadeMaxima: 10,
          codigo: "123456"),
      Produto(
          id: 1,
          nome: "Galaxy J6",
          imagem: "assets/images/J6.png",
          valor: 800.0,
          quantidade: 4,
          quantidadeMinima: 2,
          quantidadeMaxima: 10,
          codigo: "123456"),
      Produto(
          id: 1,
          nome: "Mogo G7",
          imagem: "assets/images/moto-g7.png",
          valor: 800.0,
          quantidade: 4,
          quantidadeMinima: 2,
          quantidadeMaxima: 10,
          codigo: "123456"),
      Produto(
          id: 1,
          nome: "Moto G8",
          imagem: "assets/images/moto-g8.png",
          valor: 800.0,
          quantidade: 4,
          quantidadeMinima: 2,
          quantidadeMaxima: 10,
          codigo: "123456"),
      Produto(
          id: 1,
          nome: "GMoto One",
          imagem: "assets/images/Moto-one.png",
          valor: 1500.00,
          quantidade: 4,
          quantidadeMinima: 2,
          quantidadeMaxima: 10,
          codigo: "123456"),
      Produto(
          id: 1,
          nome: "Galaxy S10",
          imagem: "assets/images/s10.png",
          valor: 800.0,
          quantidade: 4,
          quantidadeMinima: 2,
          quantidadeMaxima: 10,
          codigo: "123456"),
      Produto(
          id: 1,
          nome: "Xiaomi Note 8",
          imagem: "assets/images/Xiaomi-Note-8.png",
          valor: 800.0,
          quantidade: 4,
          quantidadeMinima: 2,
          quantidadeMaxima: 10,
          codigo: "123456")
    ];

    return produtos;
  }
}
