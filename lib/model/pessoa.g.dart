// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pessoa.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pessoa _$PessoaFromJson(Map<String, dynamic> json) {
  return new Pessoa(
      nome: json['nome'] as String,
      descricao: json['descricao'] as String,
      foto1: json['foto1'] as String,
      idUsuario: json['idUsuario'] as String);
}

Map<String, dynamic> _$PessoaToJson(Pessoa instance) => <String, dynamic>{
      'nome': instance.nome,
      'descricao': instance.descricao,
      'foto1': instance.foto1,
      'idUsuario': instance.idUsuario
    };
