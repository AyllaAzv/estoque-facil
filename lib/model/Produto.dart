class Produto {
  int id;
  String nome;
  String imagem;
  String codigo;
  int quantidade;
  int quantidadeMinima;
  int quantidadeMaxima;
  String validade;
  double valor;
  String dataCadastro;
  int idUsuario;

  Produto({
    this.id,
    this.nome,
    this.imagem,
    this.codigo,
    this.quantidade,
    this.quantidadeMinima,
    this.quantidadeMaxima,
    this.validade,
    this.valor,
    this.dataCadastro,
    this.idUsuario,
  });

    Produto.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nome = map['nome'];
    imagem = map['imagem'];
    codigo = map['codigo'];
    quantidade = map['quantidade'];
    quantidadeMinima = map['quantidadeMinima'];
    quantidadeMaxima = map['quantidadeMaxima'];
    validade = map['validade'];
    valor = map['valor'];
    dataCadastro = map['dataCadastro'];
    idUsuario = map['idUsuario'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['imagem'] = this.imagem;
    data['codigo'] = this.codigo;
    data['quantidade'] = this.quantidade;
    data['quantidadeMinima'] = this.quantidadeMinima;
    data['quantidadeMaxima'] = this.quantidadeMaxima;
    data['validade'] = this.validade;
    data['valor'] = this.valor;
    data['dataCadastro'] = this.dataCadastro;
    data['idUsuario'] = this.idUsuario;
    return data;
  }
}
