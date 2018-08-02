import 'dart:async';

import "package:flutter/material.dart";
import 'package:qrcode_reader/QRCodeReader.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

String selectedUrl = '';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

void main() => runApp(MaterialApp(
      routes: {
        '/widget': (_) => new WebviewScaffold(
              url: selectedUrl,
              appBar: new AppBar(
                title: const Text('Eternify 1'),
              ),
              withZoom: false,
              userAgent: kAndroidUserAgent ,
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
    if (data != null) {
      // setState(() {
      //     selectedUrl = data;
      // });
      //Navigator.of(context).pushNamed('/widget');
    }
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
                selectedUrl = s;
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
