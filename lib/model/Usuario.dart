class Usuario {
  int id;
  String usuario;
  String senha;

  Usuario({
    this.id,
    this.usuario,
    this.senha,
  });

  Usuario.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    usuario = map['usuario'];
    senha = map['senha'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['usuario'] = this.usuario;
    data['senha'] = this.senha;
    return data;
  }
}
