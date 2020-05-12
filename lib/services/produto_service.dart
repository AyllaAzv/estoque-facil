import 'dart:io';
import 'package:estoque_facil/models/api_response.dart';
import 'package:estoque_facil/models/produto.dart';
import 'package:estoque_facil/services/firebase_service.dart';
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

  static Future<List<Produto>> getProdutosSemEstoque() async {
    var url = "$BASE_URL/produtosSemEstoque";

    var response = await get(url);

    String json = response.body;

    List list = convert.json.decode(json);

    List<Produto> produtos =
    list.map<Produto>((map) => Produto.fromMap(map)).toList();

    return produtos;
  }

  static Future<List<Produto>> getProdutosDisponivel() async {
    var url = "$BASE_URL/produtosDisponivel";

    var response = await get(url);

    String json = response.body;

    List list = convert.json.decode(json);

    List<Produto> produtos =
    list.map<Produto>((map) => Produto.fromMap(map)).toList();

    return produtos;
  }

  static Future<ApiResponse<Produto>> getByCodigo(String codigo) async {
    try {
      var url = '$BASE_URL/produto/$codigo';

      var response = await get(url);

      Map responseMap = convert.json.decode(response.body);

      if (response.statusCode == 200) {
        Produto produto = Produto.fromMap(responseMap);

        return ApiResponse.ok(result: produto);
      }

      return ApiResponse.error(msg: responseMap["error"]);
    } catch (error, exception) {
      print("Erro no busca produto $error > $exception");

      return ApiResponse.error(msg: "Não foi possível buscar produto.");
    }
  }

  static Future<ApiResponse> saveProduto(Produto produto, File file) async {
    try {
      var url = "$BASE_URL/produto";

      if (file != null) {
        produto.imagem = await FirebaseService.uploadFirebaseStorage(file);
      } else {
        produto.imagem =
            "https://firebasestorage.googleapis.com/v0/b/estoque-facil-b0b71.appspot.com/o/Fotos%20Celulares%2Fa20.png?alt=media&token=17aaf1dc-c81b-4446-92f1-cee6c93c1f9a";
      }

      String json = produto.toJson();

      var response = await post(url, body: json);

      if (response.statusCode == 200) {
        return ApiResponse.ok(msg: "Produto salvo com sucesso.");
      }

      return ApiResponse.error(msg: "Não foi possível salvar o produto.");
    } catch (e) {
      print(e);

      return ApiResponse.error(msg: "Não foi possível salvar o produto.");
    }
  }

  static Future<ApiResponse> updateProduto(Produto produto, {File file}) async {
    try {
      var url = "$BASE_URL/produto/${produto.id}";

      if (file != null) {
        produto.imagem = await FirebaseService.uploadFirebaseStorage(file);
      }

      String json = produto.toJson();

      var response = await put(url, body: json);

      if (response.statusCode == 204) {
        return ApiResponse.ok(msg: "Produto atualizado com sucesso.");
      }

      return ApiResponse.error(msg: "Não foi possível atualizar o produto.");
    } catch (e) {
      print(e);

      return ApiResponse.error(msg: "Não foi possível atualizar o produto.");
    }
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
