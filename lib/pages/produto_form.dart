import 'dart:io';
import 'package:estoque_facil/widgets/app_button.dart';
import 'package:estoque_facil/widgets/app_datepiker.dart';
import 'package:estoque_facil/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProdutoFormPage extends StatefulWidget {
  @override
  _ProdutoFormPageState createState() => _ProdutoFormPageState();
}

class _ProdutoFormPageState extends State<ProdutoFormPage> {
  File _file;

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
          _headerFoto(),
          SizedBox(
            height: 5,
          ),
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
            keyboardType: TextInputType.number,
          ),
          AppText(
            "Quantidade Mínima",
            "Digite a quantidade máxima do produto",
            icon: Icon(Icons.filter_9_plus),
            keyboardType: TextInputType.number,
          ),
          AppText(
            "Quantidade Mínima",
            "Digite a quantidade máxima do produto",
            icon: Icon(Icons.filter_9_plus),
            keyboardType: TextInputType.number,
          ),
          AppText(
            "Valor",
            "Digite o valor do produto",
            icon: Icon(Icons.monetization_on),
          ),
          AppTextDatePiker(
              "Validade", "Digite a validade", Icon(Icons.date_range)),
          SizedBox(height: 30),
          AppButton("Cadastrar", onPressed: () {}),
        ],
      ),
    );
  }

  _headerFoto() {
    return InkWell(
      onTap: _onClickFoto,
      child: _file != null
          ? Image.file(
              _file,
              height: 200,
              fit: BoxFit.cover,
            )
          : Image.asset(
              "assets/images/sem-imagem.png",
              height: 200,
            ),
    );
  }

  void _onClickFoto() async {
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      print(file);
      setState(() {
        _file = file;
      });
    }
  }
}
