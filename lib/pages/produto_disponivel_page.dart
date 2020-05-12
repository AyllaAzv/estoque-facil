import 'package:estoque_facil/controllers/produto_model.dart';
import 'package:estoque_facil/models/produto.dart';
import 'package:estoque_facil/widgets/produtos_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProdutoDisponivelPage extends StatefulWidget {
  @override
  _ProdutoDisponivelPageState createState() => _ProdutoDisponivelPageState();
}

class _ProdutoDisponivelPageState extends State<ProdutoDisponivelPage> {
  final _model = ProdutoModel();

  @override
  void initState() {
    super.initState();

    _model.getProdutosDisponivel();
  }

  @override
  Widget build(BuildContext context) {
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
        child: ProdutosGridView(produtos),
      );
    });
  }

  Future<void> _onRefresh() {
    return _model.getProdutosDisponivel();
  }
}
