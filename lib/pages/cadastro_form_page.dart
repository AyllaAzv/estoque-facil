import 'package:estoque_facil/pages/login_page.dart';
import 'package:estoque_facil/services/usuario_service.dart';
import 'package:estoque_facil/utils/alert.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:estoque_facil/widgets/app_button.dart';
import 'package:estoque_facil/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CadastroFormPage extends StatefulWidget {
  @override
  _CadastroFormPageState createState() => _CadastroFormPageState();
}

class _CadastroFormPageState extends State<CadastroFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _tUsuario = TextEditingController();

  final _tSenha = TextEditingController();

  final _tConfirmacaoSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFececec),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Cadastre-se",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          AppText(
            "Usuário",
            "Digite um usuário",
            icon: Icon(Icons.person),
            controller: _tUsuario,
            validator: _validateUsuario,
          ),
          AppText(
            "Senha",
            "Digite uma senha",
            password: true,
            icon: Icon(Icons.lock),
            controller: _tSenha,
            validator: _validateSenha,
          ),
          AppText(
            "Confirmar Senha",
            "Confirme sua senha",
            password: true,
            icon: Icon(Icons.lock),
            controller: _tConfirmacaoSenha,
            validator: _validateConfirmacaoSenha,
          ),
          SizedBox(height: 30),
          AppButton(
            "Criar Conta",
            onPressed: _onClickCadastro,
          ),
        ],
      ),
    );
  }

  _onClickCadastro() async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    String usuario = _tUsuario.text;
    String senha = _tSenha.text;
    String confirmacaoSenha = _tConfirmacaoSenha.text;

    if (senha != confirmacaoSenha) {
      alert(context, "As senhas não conferem.");
      return;
    }

    final response = await UsuarioService.cadastrar(usuario, senha);

    if (response.ok) {
      push(context, LoginPage(), replace: true);
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

  String _validateConfirmacaoSenha(String text) {
    if (text.isEmpty) {
      return "Digite a confirmação de senha";
    }

    if (text.length < 3) {
      return "A senha deve ter pelo menos três números";
    }
    return null;
  }
}
