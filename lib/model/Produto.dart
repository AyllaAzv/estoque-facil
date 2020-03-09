class Produto {
  int id;
  String nome;
  String codigo;
  int qtd;
  int qtdMinima;
  String validade;
  double valor;
  String dataCadastro;

  Produto({
    this.id,
    this.nome,
    this.codigo,
    this.qtd,
    this.qtdMinima,
    this.validade,
    this.valor,
    this.dataCadastro,
  });

    Produto.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    codigo = map['codigo'];
    qtd = map['qtd'];
    qtdMinima = map['qtdMinima'];
    validade = map['validade'];
    valor = map['valor'];
    dataCadastro = map['dataCadastro'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['codigo'] = this.codigo;
    data['qtd'] = this.qtd;
    data['qtdMinima'] = this.qtdMinima;
    data['validade'] = this.validade;
    data['valor'] = this.valor;
    data['dataCadastro'] = this.dataCadastro;
    return data;
  }
}
