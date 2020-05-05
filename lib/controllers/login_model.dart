import 'package:estoque_facil/models/api_response.dart';
import 'package:estoque_facil/services/usuario_service.dart';
import 'package:mobx/mobx.dart';

part 'login_model.g.dart';

class LoginModel = LoginModelBase with _$LoginModel;

abstract class LoginModelBase with Store {

  @observable
  ApiResponse response;

  @observable
  Exception error;

  @action
  login(String usuario, String senha) async {
    try {
      response = await UsuarioService.login(usuario, senha);
    } catch(e) {
      this.error = e;
    }
  }
}