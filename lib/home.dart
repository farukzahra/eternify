import 'dart:async';

import 'package:flutter/material.dart';

import 'package:qrcode_reader/QRCodeReader.dart';

class HomeScreen extends StatefulWidget {
  String url;

  HomeScreen({this.url});

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String url;

  Future<String> _barcodeString;

  _HomeScreenState({this.url});

  _buildWebView(data) {
    return new Text('Selecione um QRCODE');
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Eternify'),
      ),
      resizeToAvoidBottomPadding: false,
      body: new Center(
          child: new FutureBuilder<String>(
              future: _barcodeString,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return _buildWebView(snapshot.data);
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
              setState(() {
                url = s;
              });
              Navigator.of(context).pushNamed('/widget');
            });
          });
        },
        tooltip: 'Ler o QRCode',
        child: new Icon(Icons.search),
      ),
    );
  }
}