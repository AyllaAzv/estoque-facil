import 'package:estoque_facil/models/api_response.dart';
import 'package:estoque_facil/models/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsuarioService {
  static final BASE_URL = "http://192.168.0.108:3333";

  static Future<ApiResponse<Usuario>> login(
      String usuario, String senha) async {
    try {
      var url = '$BASE_URL/sessions';

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      Map params = {
        "usuario": usuario,
        "senha": senha,
      };

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      Map responseMap = json.decode(response.body);

      if (response.statusCode == 200) {
        Usuario user = Usuario.fromMap(responseMap);

        user.save();

        Usuario user2 = await Usuario.get();
        print(user2);

        return ApiResponse.ok(result: user);
      }

      return ApiResponse.error(msg: responseMap["error"]);
    } catch (error, exception) {
      print("Erro no login $error > $exception");

      return ApiResponse.error(msg: "Não foi possível fazer o login.");
    }
  }

  static Future<ApiResponse> cadastrar(String usuario, String senha) async {
    try {
      var url = '$BASE_URL/usuario';

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      Map params = {
        "usuario": usuario,
        "senha": senha,
      };

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      if (response.statusCode == 200) {
        return ApiResponse.ok(msg: "Usuário criado com sucesso.");
      }
      Map responseMap = json.decode(response.body);

      return ApiResponse.error(msg: responseMap["error"]);
    } catch (error, exception) {
      print("Erro no cadastro $error > $exception");

      return ApiResponse.error(msg: "Não foi possível criar o usuário.");
    }
  }
}
