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
  fetch() async {
    try {
      this.produtos = await ProdutoService.getProdutos();
    } catch(e) {
      this.error = e;
    }
  }
}