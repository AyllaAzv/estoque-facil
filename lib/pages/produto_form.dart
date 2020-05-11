import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:estoque_facil/models/produto.dart';
import 'package:estoque_facil/pages/home_page.dart';
import 'package:estoque_facil/services/produto_service.dart';
import 'package:estoque_facil/utils/alert.dart';
import 'package:estoque_facil/utils/nav.dart';
import 'package:estoque_facil/widgets/app_button.dart';
import 'package:estoque_facil/widgets/app_datepiker.dart';
import 'package:estoque_facil/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

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
  final _tValor = MoneyMaskedTextController(
      precision: 2,
      leftSymbol: 'R\$ ',
      decimalSeparator: ',',
      thousandSeparator: '.');
  final _tValidade = TextEditingController();

  File _file;
  String _urlFoto;

  var _showProgress = false;

  Produto get produto => widget.produto;

  @override
  void initState() {
    super.initState();

    if (produto != null) {
      _tNome.text = produto.nome;
      _tCodigo.text = produto.codigo;
      _tQuantidade.text = produto.quantidade.toString();
      _tQuantidadeMinima.text = produto.quantidadeMinima.toString();
      _tQuantidadeMaxima.text = produto.quantidadeMaxima.toString();
      _tValor.text = produto.valor.toString();
      _tValidade.text = produto.validade;
      _urlFoto = produto.imagem;
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
          produto != null ? produto.nome : "Novo Produto",
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
            validator: _validateNome,
          ),
          AppText(
            "Código",
            "Digite o código do produto",
            icon: Icon(Icons.confirmation_number),
            controller: _tCodigo,
            validator: _validateCodigo,
          ),
          AppText(
            "Quantidade",
            "Digite a quantidade do produto",
            icon: Icon(Icons.filter_5),
            keyboardType: TextInputType.number,
            controller: _tQuantidade,
            validator: _validateQuantidade,
          ),
          AppText(
            "Quantidade Mínima",
            "Digite a quantidade mínima do produto",
            icon: Icon(Icons.filter_9_plus),
            keyboardType: TextInputType.number,
            controller: _tQuantidadeMinima,
            validator: _validateQuantidadeMinima,
          ),
          AppText(
            "Quantidade Máxima",
            "Digite a quantidade máxima do produto",
            icon: Icon(Icons.filter_9_plus),
            keyboardType: TextInputType.number,
            controller: _tQuantidadeMaxima,
            validator: _validateQuantidadeMaxima,
          ),
          AppText(
            "Valor",
            "Digite o valor do produto",
            icon: Icon(Icons.monetization_on),
            keyboardType: TextInputType.number,
            controller: _tValor,
            validator: _validateValor,
          ),
          AppTextDatePiker(
            "Validade",
            "Digite a validade",
            Icon(Icons.date_range),
            controller: _tValidade,
            validator: _validateValidade,
          ),
          SizedBox(height: 30),
          AppButton(
            "Salvar",
            showProgress: _showProgress,
            onPressed: produto == null ? _onClickCadastrar : _onClickAtualizar,
          ),
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
          : produto != null
              ? CachedNetworkImage(
                  imageUrl: produto.imagem,
                  height: 200,
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
      setState(() {
        _file = file;
      });
    }
  }

  _onClickCadastrar() async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    setState(() {
      _showProgress = true;
    });

    var data = DateTime.now();

    Produto p = Produto(
      nome: _tNome.text,
      codigo: _tCodigo.text,
      quantidade: int.parse(_tQuantidade.text),
      quantidadeMinima: int.parse(_tQuantidadeMinima.text),
      quantidadeMaxima: int.parse(_tQuantidadeMaxima.text),
      valor: _tValor.numberValue,
      validade: _tValidade.text,
      dataCadastro: data.toString(),
    );

    final response = await ProdutoService.saveProduto(p, _file);

    setState(() {
      _showProgress = false;
    });

    if (response.ok) {
      alert(context, response.msg, callback: () {
        push(context, HomePage(), replace: true);
      });
    } else {
      alert(context, response.msg);
    }
  }

  _onClickAtualizar() async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }

    setState(() {
      _showProgress = true;
    });

    Produto p = Produto(
      id: produto.id,
      nome: _tNome.text,
      codigo: _tCodigo.text,
      quantidade: int.parse(_tQuantidade.text),
      quantidadeMinima: int.parse(_tQuantidadeMinima.text),
      quantidadeMaxima: int.parse(_tQuantidadeMaxima.text),
      valor: _tValor.numberValue,
      validade: _tValidade.text,
      imagem: _urlFoto,
    );

    final response = await ProdutoService.updateProduto(p, file: _file);

    setState(() {
      _showProgress = false;
    });

    if (response.ok) {
      alert(context, response.msg, callback: () {
        push(context, HomePage(), replace: true);
      });
    } else {
      alert(context, response.msg);
    }
  }

  String _validateNome(String text) {
    if (text.isEmpty) {
      return "Digite o nome do produto";
    }

    if (text.length < 3) {
      return "Nome deve ter pelo menos 3 letras";
    }
    return null;
  }

  String _validateCodigo(String text) {
    if (text.isEmpty) {
      return "Digite o código do produto";
    }

    return null;
  }

  String _validateQuantidade(String text) {
    if (text.isEmpty) {
      return "Digite a quantidade";
    }

    return null;
  }

  String _validateQuantidadeMinima(String text) {
    if (text.isEmpty) {
      return "Digite a quantidade mínima";
    }

    return null;
  }

  String _validateQuantidadeMaxima(String text) {
    if (text.isEmpty) {
      return "Digite a quantidade máxima";
    }

    return null;
  }

  String _validateValor(String text) {
    if (text.isEmpty) {
      return "Digite o valor";
    }

    return null;
  }

  String _validateValidade(DateTime data) {
    if (data == null) {
      return "Digite a validade";
    }

    return null;
  }
}
