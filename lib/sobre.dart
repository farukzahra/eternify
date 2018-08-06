import 'package:flutter/material.dart';

import './utils.dart';

class SobreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: const Text('Sobre'),
        ),
        body: new Center(
            child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              'images/eternify.png',
              width: 341.0,
              height: 133.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            new Text('Para mais informações acesse',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 15.0,
            ),
            //new Text('www.eternify.com.br'),
            _buildTap(context)
          ],
        )));
  }

  Widget _buildTap(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("onTap called.");
        Navigator.push(context, routeWebView('http://www.eternify.com.br'));
      },
      child: new Text('www.eternify.com.br',style: TextStyle(decoration: TextDecoration.underline)),
    );
  }
}
