import 'package:json_annotation/json_annotation.dart';

part 'pessoa.g.dart';

@JsonSerializable(nullable: false)
class Pessoa {
  String nome;
  String descricao;
  String foto1;
  String idUsuario;

  
  Pessoa({this.nome, this.descricao, this.foto1, this.idUsuario});

  

  factory Pessoa.fromJson(Map<String, dynamic> json) => _$PessoaFromJson(json);
  Map<String, dynamic> toJson() => _$PessoaToJson(this);
}