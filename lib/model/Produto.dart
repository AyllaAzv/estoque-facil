class Produto {
  int id;
  String nome;
  String imagem;
  String codigo;
  int qtd;
  int qtdMinima;
  int qtdMaxima;
  String validade;
  double valor;
  String dataCadastro;

  Produto({
    this.id,
    this.nome,
    this.imagem,
    this.codigo,
    this.qtd,
    this.qtdMinima,
    this.qtdMaxima,
    this.validade,
    this.valor,
    this.dataCadastro,
  });

    Produto.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    imagem = map['imagem'];
    codigo = map['codigo'];
    qtd = map['qtd'];
    qtdMinima = map['qtdMinima'];
    qtdMaxima = map['qtdMaxima'];
    validade = map['validade'];
    valor = map['valor'];
    dataCadastro = map['dataCadastro'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['imagem'] = this.imagem;
    data['codigo'] = this.codigo;
    data['qtd'] = this.qtd;
    data['qtdMinima'] = this.qtdMinima;
    data['qtdMaxima'] = this.qtdMaxima;
    data['validade'] = this.validade;
    data['valor'] = this.valor;
    data['dataCadastro'] = this.dataCadastro;
    return data;
  }
}
