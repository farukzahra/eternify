import 'dart:async';

import 'package:flutter/material.dart';

import 'package:qrcode_reader/QRCodeReader.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

typedef QRcodeCallBack = void Function(String url);


class _HomeScreenState extends State<HomeScreen> {
  Future<String> _barcodeString;

  final QRcodeCallBack onQRcodeSelect;

  _HomeScreenState({this.onQRcodeSelect});

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
                widget.selectedUrl = s;
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