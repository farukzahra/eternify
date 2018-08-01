import 'dart:async';

import "package:flutter/material.dart";
import 'package:qrcode_reader/QRCodeReader.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ProcurarPessoa extends StatefulWidget {
  ProcurarPessoa({Key key, this.title}) : super(key: key);

  final String title;

  final Map<String, dynamic> pluginParameters = {};

  @override
  _ProcurarPessoa createState() => new _ProcurarPessoa();
}

class _ProcurarPessoa extends State<ProcurarPessoa> {
  Future<String> _barcodeString;

  _buildWebView(data) {
    return data != null
        ? new WebviewScaffold(
            url: data,
            appBar: new AppBar(
              title: new Text("Widget webview"),
            ))
        : new Text('');
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
