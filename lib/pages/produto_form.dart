import 'package:estoque_facil/widgets/app_button.dart';
import 'package:estoque_facil/widgets/app_text.dart';
import 'package:flutter/material.dart';

class ProdutoFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFececec),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Novo Produto",
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
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          AppText(
            "Nome",
            "Digite o nome do produto",
            icon: Icon(Icons.add_box),
          ),
          AppText(
            "Código",
            "Digite o código do produto",
            icon: Icon(Icons.confirmation_number),
          ),
          AppText(
            "Quantidade",
            "Digite a quantidade do produto",
            icon: Icon(Icons.filter_5),
          ),
          AppText(
            "Quantidade Mínima",
            "Digite a quantidade mínima do produto",
            icon: Icon(Icons.filter_9_plus),
          ),
          AppText(
            "Valor",
            "Digite o valor do produto",
            icon: Icon(Icons.monetization_on),
          ),
          AppText(
            "Validade",
            "Digite a validade do produto",
            icon: Icon(Icons.date_range),
          ),
          SizedBox(height: 30),
          AppButton("Entrar", onPressed: () {}),
        ],
      ),
    );
  }
}
