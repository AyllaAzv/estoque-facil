import 'package:estoque_facil/models/produto.dart';
import 'package:estoque_facil/services/produto_service.dart';
import 'package:mobx/mobx.dart';

part 'produto_model.g.dart';

class ProdutoModel = ProdutoModelBase with _$ProdutoModel;

abstract class ProdutoModelBase with Store {

  @observable
  List<Produto> produtos;

  @observable
  Exception error;

  @action
  getProdutos() async {
    try {
      this.produtos = await ProdutoService.getProdutos();
    } catch(e) {
      this.error = e;
    }
  }

  @action
  getProdutosDisponivel() async {
    try {
      this.produtos = await ProdutoService.getProdutosDisponivel();
    } catch(e) {
      this.error = e;
    }
  }

  @action
  getProdutosSemEstoque() async {
    try {
      this.produtos = await ProdutoService.getProdutosSemEstoque();
    } catch(e) {
      this.error = e;
    }
  }
}