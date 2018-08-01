import 'dart:async';

import "package:flutter/material.dart";
import 'package:qrcode_reader/QRCodeReader.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String selectedUrl = '';

void main() => runApp(MaterialApp(
      routes: {        
        '/widget': (_) => new WebviewScaffold(
              url: selectedUrl,
              appBar: new AppBar(
                title: const Text('Widget webview'),
              ),
              withZoom: true,
              withLocalStorage: true,
            )
      },
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String> _barcodeString;

  _buildWebView(data) {
    setState(() {
          selectedUrl = data;
    });
    if(data != null) {
      Navigator.of(context).pushNamed('/widget');
    }
    return new Text('Selecione um QRCODE');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Buscar Memórias'),
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
          });
        },
        tooltip: 'Reader the QRCode',
        child: new Icon(Icons.add_a_photo),
      ),
    );
  }
}
