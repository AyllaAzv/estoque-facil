import 'dart:io';
import 'package:estoque_facil/models/produto.dart';
import 'package:estoque_facil/widgets/app_button.dart';
import 'package:estoque_facil/widgets/app_datepiker.dart';
import 'package:estoque_facil/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProdutoFormPage extends StatefulWidget {
  Produto produto;

  ProdutoFormPage({this.produto});

  @override
  _ProdutoFormPageState createState() => _ProdutoFormPageState();
}

class _ProdutoFormPageState extends State<ProdutoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _tNome = TextEditingController();
  final _tCodigo = TextEditingController();
  final _tQuantidade = TextEditingController();
  final _tQuantidadeMinima = TextEditingController();
  final _tQuantidadeMaxima = TextEditingController();
  final _tValor = TextEditingController();
  final _tValidade = TextEditingController();

  File _file;

  Produto get produto => widget.produto;

  @override
  void initState() {
    super.initState();

    if(produto != null) {
      _tNome.text = produto.nome;
      _tCodigo.text = produto.codigo;
      _tQuantidade.text = produto.quantidade.toString();
      _tQuantidadeMinima.text = produto.quantidadeMinima.toString();
      _tValor.text = produto.valor.toString();
      _tValor.text = produto.validade;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFececec),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          produto.nome ?? "Novo Produto",
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
          _headerFoto(),
          SizedBox(
            height: 5,
          ),
          AppText(
            "Nome",
            "Digite o nome do produto",
            icon: Icon(Icons.add_box),
            controller: _tNome,
          ),
          AppText(
            "Código",
            "Digite o código do produto",
            icon: Icon(Icons.confirmation_number),
            controller: _tCodigo,
          ),
          AppText(
            "Quantidade",
            "Digite a quantidade do produto",
            icon: Icon(Icons.filter_5),
            keyboardType: TextInputType.number,
            controller: _tQuantidade,
          ),
          AppText(
            "Quantidade Mínima",
            "Digite a quantidade máxima do produto",
            icon: Icon(Icons.filter_9_plus),
            keyboardType: TextInputType.number,
            controller: _tQuantidadeMinima,
          ),
          AppText(
            "Quantidade Mínima",
            "Digite a quantidade máxima do produto",
            icon: Icon(Icons.filter_9_plus),
            keyboardType: TextInputType.number,
            controller: _tQuantidadeMaxima,
          ),
          AppText(
            "Valor",
            "Digite o valor do produto",
            icon: Icon(Icons.monetization_on),
            keyboardType: TextInputType.number,
            controller: _tValor,
          ),
          AppTextDatePiker(
            "Validade",
            "Digite a validade",
            Icon(Icons.date_range),
            controller: _tValidade,
          ),
          SizedBox(height: 30),
          AppButton("Cadastrar", onPressed: _onClickCadastrar),
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

  _onClickCadastrar() {
    var data = DateTime.now();
  }

}
