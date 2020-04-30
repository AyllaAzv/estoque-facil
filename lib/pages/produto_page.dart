import 'package:estoque_facil/model/Produto.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class ProdutoPage extends StatelessWidget {
  Produto produto;

  ProdutoPage(this.produto);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            expandedHeight: 350.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text(produto.nome),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    padding: EdgeInsets.all(60),
                    child: Image.asset(produto.imagem),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.9),
                        end: Alignment(0.0, 0.0),
                        colors: <Color>[
                          Color(0x60000000),
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              _menu(),
            ],
          ),
          SliverList(delegate: _list()),
        ],
      ),
    );
  }

  _list() {
    var f = NumberFormat.currency(
        customPattern: "#,###.0##", locale: "pt_BR", decimalDigits: 2);

    return SliverChildListDelegate([
      ListTile(
        leading: Container(
          alignment: Alignment.center,
          width: 40,
          child: Icon(Icons.confirmation_number),
        ),
        title: Text(
          'Código',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          produto.codigo,
          style: TextStyle(fontSize: 17),
        ),
      ),
      ListTile(
        leading: Container(
          alignment: Alignment.center,
          width: 40,
          child: Icon(Icons.filter_5),
        ),
        title: Text(
          'Quantidade',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          produto.quantidade.toString(),
          style: TextStyle(fontSize: 17),
        ),
      ),
      ListTile(
        leading: Container(
          alignment: Alignment.center,
          width: 40,
          child: Icon(Icons.filter_9_plus),
        ),
        title: Text(
          'Quantidade máxima',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          produto.quantidadeMaxima.toString(),
          style: TextStyle(fontSize: 17),
        ),
      ),
      ListTile(
        leading: Container(
          alignment: Alignment.center,
          width: 40,
          child: Icon(Icons.filter_9_plus),
        ),
        title: Text(
          'Quantidade mínima',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          produto.quantidadeMinima.toString(),
          style: TextStyle(fontSize: 17),
        ),
      ),
      ListTile(
        leading: Container(
          alignment: Alignment.center,
          width: 40,
          child: Icon(Icons.monetization_on),
        ),
        title: Text(
          'Valor',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          "R\$ ${f.format(produto.valor).toString()}",
          style: TextStyle(fontSize: 17),
        ),
      ),
      ListTile(
        leading: Container(
          alignment: Alignment.center,
          width: 40,
          child: Icon(Icons.date_range),
        ),
        title: Text(
          'Validade',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          produto.validade ?? "Não possui validade",
          style: TextStyle(fontSize: 17),
        ),
      ),
    ]);
  }

  _menu() {
    return PopupMenuButton<String>(
      onSelected: (String valor) => _onClickPopUpMenu(valor),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: "Editar",
            child: Text(
              "Editar",
            ),
          ),
          PopupMenuItem(
            value: "Deletar",
            child: Text(
              "Deletar",
            ),
          ),
          PopupMenuItem(
            value: "Compartilhar",
            child: Text(
              "Compartilhar",
            ),
          ),
        ];
      },
    );
  }

  _onClickPopUpMenu(String valor) {
    switch (valor) {
      case "Editar":
        print("editar");
        break;
      case "Deletar":
        print("deletar");
        break;
      case "Compartilhar":
        _onClickCompartilhar();
        break;
    }
  }

  _onClickCompartilhar() {
    Share.share(produto.nome);
  }
}
