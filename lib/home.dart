import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import './pessoa.dart';
import './utils.dart';

const CHAMADA_GET_PESSOA = "http://eternify.com.br/pessoa/get?id=";

const CHAMADA_FIND_PESSOA = "http://eternify.com.br/findpessoa.jsf?pessoa=";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> _barcodeString;
  List<String> lista = [""];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Eternify'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: new Image.asset('images/eternify.png'),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Limpar Histórico'),
              onTap: () {
                _limparHistorico(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed('/SobreScreen');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () {
                exit(0);
              },
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: new Center(
          child: new FutureBuilder<String>(
              future: _barcodeString,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return _buildWebView();
              })),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          setState(() {
            _barcodeString = new QRCodeReader()
                .setAutoFocusIntervalInMs(200)
                .setForceAutoFocus(true)
                .setTorchEnabled(true)
                .setHandlePermissions(true)
                .setExecuteAfterPermissionGranted(true)
                .scan();
            //print('_barcodeString ' + _barcodeString.toString());
            _barcodeString.then((s) {
              _salvaBusca(s);
              Navigator.push(context, routeWebView(s));
            });
          });
        },
        tooltip: 'Ler o QRCode',
        child: new Icon(Icons.search),
      ),
    );
  }

  _buildWebView() {
    return new FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            //return new Text('loading...');
            return CircularProgressIndicator();
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<String> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(_convertToPessoa(values[index]).foto),
              ),
              title: new Text(_convertToPessoa(values[index]).nome),
              subtitle: new Text(_convertToPessoa(values[index]).dataHora),
              trailing:
                  _buildSearchButton(context, _convertToPessoa(values[index])),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchButton(BuildContext context, Pessoa pessoa) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        Navigator.push(
            context, routeWebView(CHAMADA_FIND_PESSOA + pessoa.id.toString()));
      },
    );
  }

  Pessoa _convertToPessoa(valor) {
    Map userMap = json.decode(valor);
    return new Pessoa.fromJson(userMap);
  }

  Future<List<String>> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lista = prefs.getStringList("lista");

    if (lista == null) {
      lista = new List<String>();
    }
    return lista;
  }

  _salvaBusca(url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lista = prefs.getStringList("lista");
    if (lista == null) {
      lista = new List<String>();
    }


        

    var response = await http.get(Uri.parse(CHAMADA_GET_PESSOA + url.toString().split("pessoa=")[1]));

    Map<String, dynamic> pessoa = json.decode(response.body);
    if (pessoa != null) {
      var now = new DateTime.now();
      var formatter = new DateFormat('dd/MM/yyyy HH:mm');
      pessoa['dataHora'] = formatter.format(now);
      lista.add(json.encode(pessoa));
      prefs.setStringList("lista", lista);
      print("Lista >>> " + prefs.getStringList("lista").toString());
    }
  }

  _limparHistorico(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('lista');
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }
}
