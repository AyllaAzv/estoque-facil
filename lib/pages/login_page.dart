import 'package:estoque_facil/controllers/login_model.dart';
import 'package:estoque_facil/models/api_response.dart';
import 'package:estoque_facil/models/usuario.dart';
import 'package:estoque_facil/pages/home_page.dart';
import 'package:estoque_facil/utils/alert.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:estoque_facil/widgets/app_button_login.dart';
import 'package:estoque_facil/widgets/app_text_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _tUsuario = TextEditingController();

  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  final _model = LoginModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      backgroundColor: Color(0xFF102d3d),
    );
  }

  _body(context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          SizedBox(height: 70),
          Image.asset(
            "assets/images/logo.png",
            height: 100,
          ),
          SizedBox(height: 20),
          AppTextLogin(
            "Usuário",
            "Digite seu usuário",
            controller: _tUsuario,
            validator: _validateUsuario,
            nextFocus: _focusSenha,
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          AppTextLogin(
            "Senha",
            "Digite sua senha",
            password: true,
            controller: _tSenha,
            validator: _validateSenha,
            focusNode: _focusSenha,
            icon: Icon(
              Icons.https,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Text(
                  "Não tem cadastro?",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          AppButtonLogin("Entrar", onPressed: _onClickLogin),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/gmail.png",
                    height: 50,
                  )),
              SizedBox(width: 10),
              InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/facebook.png",
                    height: 50,
                  )),
              SizedBox(width: 10),
              InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/images/twitter.png",
                  height: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _onClickLogin() async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    String usuario = _tUsuario.text;
    String senha = _tSenha.text;

    await _model.login(usuario, senha);

    ApiResponse response = _model.response;
  print(response.ok);
    if (response.ok) {
      Usuario user = response.result;
      print(">>> ${user.usuario}");
      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.msg);
    }
  }

  String _validateUsuario(String text) {
    if (text.isEmpty) {
      return "Digite o usuário";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }

    if (text.length < 3) {
      return "A senha deve ter pelo menos três números";
    }
    return null;
  }
}
