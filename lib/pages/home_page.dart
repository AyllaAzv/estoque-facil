import 'package:cached_network_image/cached_network_image.dart';
import 'package:estoque_facil/controllers/produto_model.dart';
import 'package:estoque_facil/models/api_response.dart';
import 'package:estoque_facil/models/produto.dart';
import 'package:estoque_facil/pages/produto_form_page.dart';
import 'package:estoque_facil/pages/produto_page.dart';
import 'package:estoque_facil/services/produto_service.dart';
import 'package:estoque_facil/utils/alert.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:estoque_facil/widgets/app_text.dart';
import 'package:estoque_facil/widgets/drawer_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:barcode_scan/barcode_scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _model = ProdutoModel();

  String _codigo = null;

  final _formKey = GlobalKey<FormState>();

  final _tQuantidade = TextEditingController();

  @override
  void initState() {
    super.initState();

    _model.getProdutos();
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
        onPressed: _scanCode,
        label: Text("Ler Código"),
        icon: Icon(Icons.chrome_reader_mode),
      ),
    );
  }

  _body() {
    return Observer(builder: (_) {
      List<Produto> produtos = _model.produtos;

      if (_model.error != null) {
        return Center(
          child: Text(
            "Erro ao carregar produtos.",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      if (produtos == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: _gridView(produtos),
      );
    });
  }

  _gridView(List<Produto> produtos) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemCount: produtos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.5),
      ),
      itemBuilder: (context, index) {
        return _itemView(produtos, index);
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
      onLongPress: () => _onLongClickProduto(context, p),
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
                p.nome.toUpperCase(),
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

  _scanCode() async {
    try {
      String barcode = await BarcodeScanner.scan();

      setState(() => this._codigo = barcode);

      return _darBaixa();
    } catch (e) {
      setState(() => this._codigo = null);
    }
  }

  _darBaixa() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Column(
              children: <Widget>[
                Image.asset("assets/images/logo_estoque.png", height: 50),
                SizedBox(height: 20),
                Text("Código: $_codigo"),
              ],
            ),
            content: Form(
              key: _formKey,
              child: AppText(
                "Quantidade",
                "Digite a quantidade",
                icon: Icon(Icons.confirmation_number),
                keyboardType: TextInputType.number,
                controller: _tQuantidade,
                validator: _validateQuantidade,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Dar baixa"),
                onPressed: () async {
                  bool formOk = _formKey.currentState.validate();

                  if (!formOk) {
                    return;
                  }

                  ApiResponse response =
                      await ProdutoService.getByCodigo(_codigo);

                  if (response.ok) {
                    Produto produto = response.result;
                    _updateQuantidade(produto);
                  } else {
                    Navigator.pop(context);
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

  _updateQuantidade(Produto produto) async {
    int qtdFinal = produto.quantidade - int.parse(_tQuantidade.text);

    if(qtdFinal >= 0) {
      produto.quantidade = qtdFinal;

      final response = await ProdutoService.updateProduto(produto);

      if (response.ok) {
        Navigator.pop(context);
        alert(context, response.msg, callback: () {
          _model.getProdutos();
        });
      } else {
        Navigator.pop(context);
        alert(context, response.msg);
      }
    } else {
      alert(context, "A quantidade digitada ultrapassa a quantidade do produto no estoque.");
    }
  }

  String _validateQuantidade(String text) {
    if (text.isEmpty) {
      return "Digite a quantidade";
    }

    return null;
  }

  _img(String img) {
    return CachedNetworkImage(
      imageUrl: img ??
          "https://firebasestorage.googleapis.com/v0/b/estoque-facil-b0b71.appspot.com/o/Fotos%20Celulares%2FGoogle%20Pixel.png?alt=media&token=19912a9e-796f-446f-9173-65ccd1c3fe96",
      height: MediaQuery.of(context).size.height / 6,
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

  _onLongClickProduto(BuildContext context, Produto produto) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                produto.nome,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text("Detalhes"),
              leading: Icon(
                Icons.shopping_basket,
              ),
              onTap: () {
                Navigator.pop(context);
                push(context, ProdutoPage(produto));
              },
            ),
            ListTile(
              title: Text("Compartilhar"),
              leading: Icon(Icons.share),
              onTap: () {
                Navigator.pop(context);
                _onClickCompartilhar(produto);
              },
            ),
          ],
        );
      },
    );
  }

  _onClickCompartilhar(Produto produto) {
    Share.share(produto.nome);
  }

  Future<void> _onRefresh() {
    return _model.getProdutos();
  }
}
