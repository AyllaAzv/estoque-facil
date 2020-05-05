import 'package:estoque_facil/models/api_response.dart';
import 'package:estoque_facil/models/produto.dart';
import 'dart:convert' as convert;

import 'package:estoque_facil/utils/http_helper.dart';

class ProdutoService {
  static final BASE_URL = "http://192.168.0.108:3333";

  static Future<List<Produto>> getProdutos() async {
    var url = "$BASE_URL/profile";

    var response = await get(url);

    String json = response.body;

    List list = convert.json.decode(json);

    List<Produto> produtos =
        list.map<Produto>((map) => Produto.fromMap(map)).toList();

    return produtos;
  }

  static Future<ApiResponse<bool>> deleteProduto(Produto p) async {
    try {
      var url = "$BASE_URL/produto/${p.id}";

      var response = await delete(url);

      if (response.statusCode == 204) {
        return ApiResponse.ok(result: true);
      }

      return ApiResponse.error(msg: "Não foi possível excluir este produto!");
    } catch (e) {
      return ApiResponse.error(msg: "Não foi possível excluir este produto!");
    }
  }
}
