class Pessoa {
  final int id;
  final String nome;
  final String foto;

  Pessoa(this.id, this.nome, this.foto);

  Pessoa.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        foto = json['foto'];

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'nome': nome,
      'foto': foto,
    };
}