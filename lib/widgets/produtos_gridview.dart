import 'package:cached_network_image/cached_network_image.dart';
import 'package:estoque_facil/models/produto.dart';
import 'package:estoque_facil/pages/produto_page.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';

class ProdutosGridView extends StatefulWidget {
  List<Produto> produtos;

  ProdutosGridView(this.produtos);

  @override
  _ProdutosGridViewState createState() => _ProdutosGridViewState();
}

class _ProdutosGridViewState extends State<ProdutosGridView> {
  @override
  Widget build(BuildContext context) {
    return _gridView();
  }

  _gridView() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      itemCount: widget.produtos.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 1.5),
      ),
      itemBuilder: (context, index) {
        return _itemView(widget.produtos, index);
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

  _img(String img) {
    return CachedNetworkImage(
      imageUrl: img ??
          "https://firebasestorage.googleapis.com/v0/b/estoque-facil-b0b71.appspot.com/o/Fotos%20Celulares%2FGoogle%20Pixel.png?alt=media&token=19912a9e-796f-446f-9173-65ccd1c3fe96",
      height: MediaQuery.of(context).size.height / 6,
    );
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
}
