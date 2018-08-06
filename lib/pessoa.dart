class Pessoa {
  final int id;
  final String nome;
  final String foto;
  final String dataHora;

  Pessoa(this.id, this.nome, this.foto, this.dataHora);

  Pessoa.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        foto = json['foto'],
        dataHora = json['dataHora'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'foto': foto,
        'dataHora': dataHora,
      };
}
