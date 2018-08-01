import 'dart:convert';
import 'package:eternify/model/pessoa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NovaPessoa extends StatefulWidget {
  NovaPessoa({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _NovaPessoa createState() => new _NovaPessoa();
}

class _NovaPessoa extends State<NovaPessoa> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final Pessoa pessoa = new Pessoa();

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      //_autovalidate = true; // Start validating on every change.
      print('Please fix the errors in red before submitting.');
    } else {
      form.save();
      var url = "https://eternify-ba7a8.firebaseio.com/pessoa.json";
      http.post(url, body: json.encode(pessoa)).then((response) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      });
      print('${pessoa.nome}\'s phone number is ${pessoa.descricao}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Nova Memória'),
      ),
      resizeToAvoidBottomPadding: false,
      body: new Form(
        key: _formKey,
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new ListTile(
                leading: const Icon(Icons.person),
                title: new TextFormField(
                  onSaved: (String value) {
                    pessoa.nome = value;
                  },
                  decoration: new InputDecoration(
                    hintText: "Nome",
                  ),
                ),
              ),
              
              new ListTile(
                leading: const Icon(Icons.photo),
                title: new TextFormField(
                  onSaved: (String value) {
                    pessoa.foto1 = value;
                  },
                  decoration: new InputDecoration(
                    hintText: "Imagem",
                  ),
                ),
              ),  
              new ListTile(
                leading: const Icon(Icons.description),
                title: new TextFormField( 
                  maxLines: null,
                  keyboardType: TextInputType.multiline,            
                  onSaved: (String value) {
                    pessoa.descricao = value;
                  },
                  decoration: new InputDecoration(
                    hintText: "Descrição",                  
                  ),
                ),
              ),           
              new Center(
                child: new RaisedButton(
                  child: const Text('Enviar'),
                  onPressed: _handleSubmitted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
