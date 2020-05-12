import 'package:cached_network_image/cached_network_image.dart';
import 'package:estoque_facil/controllers/produto_model.dart';
import 'package:estoque_facil/models/api_response.dart';
import 'package:estoque_facil/models/produto.dart';
import 'package:estoque_facil/pages/home_page.dart';
import 'package:estoque_facil/pages/produto_form_page.dart';
import 'package:estoque_facil/services/produto_service.dart';
import 'package:estoque_facil/utils/alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:estoque_facil/utils/nav.dart';

class ProdutoPage extends StatefulWidget {
  Produto produto;

  ProdutoPage(this.produto);

  @override
  _ProdutoPageState createState() => _ProdutoPageState();
}

class _ProdutoPageState extends State<ProdutoPage> {
  final _model = ProdutoModel();

  Produto get produto => widget.produto;

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
              title: Text(
                produto.nome.toUpperCase(),
                style: TextStyle(fontSize: 17),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    padding: EdgeInsets.all(60),
                    child: CachedNetworkImage(
                      imageUrl: produto.imagem ??
                          "https://firebasestorage.googleapis.com/v0/b/estoque-facil-b0b71.appspot.com/o/Fotos%20Celulares%2FGoogle%20Pixel.png?alt=media&token=19912a9e-796f-446f-9173-65ccd1c3fe96",
                    ),
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
        push(context, ProdutoFormPage(produto: produto));
        break;
      case "Deletar":
        _onClickDeletar();
        break;
      case "Compartilhar":
        _onClickCompartilhar();
        break;
    }
  }

  _onClickDeletar() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Image.asset("assets/images/logo_estoque.png", height: 50),
            content: Text("Tem certeza de que deseja deletar este produto?"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Sim"),
                onPressed: () async {
                  ApiResponse<bool> response =
                      await ProdutoService.deleteProduto(produto);

                  if (response.ok) {
                    pop(context);
                    push(context, HomePage());
                  } else {
                    alert(context, response.msg);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  _onClickCompartilhar() {
    Share.share(produto.nome);
  }
}
