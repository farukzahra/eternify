import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:qrcode_reader/QRCodeReader.dart';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> _barcodeString;

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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new WebviewScaffold(
                          url: s,
                          appBar: new AppBar(
                            title: const Text('Eternify'),
                          ),
                          withZoom: false,
                          userAgent: kAndroidUserAgent,
                          withLocalStorage: true,
                        )),
              );
            });
          });
        },
        tooltip: 'Ler o QRCode',
        child: new Icon(Icons.search),
      ),
    );
  }
}
