import 'package:estoque_facil/models/Produto.dart';
import 'dart:convert' as convert;

import 'package:estoque_facil/utils/http_helper.dart';

class ProdutoService {
  static final BASE_URL = "http://192.168.0.108:3333";

  static Future<List<Produto>> getProdutos() async {

    var url = "$BASE_URL/profile";

    var response = await get(url);

    String json = response.body;
    print(response.body);
    List list = convert.json.decode(json);

    List<Produto> produtos =
        list.map<Produto>((map) => Produto.fromMap(map)).toList();

    return produtos;
  }
}
