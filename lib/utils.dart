import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

MaterialPageRoute routeWebView(String url) {
  return MaterialPageRoute(
      builder: (context) => new WebviewScaffold(
            url: url,
            appBar: new AppBar(
              title: const Text('Eternify'),
            ),
            withZoom: false,
            userAgent: kAndroidUserAgent,
            withJavascript: true,
            withLocalStorage: true,
          ));
}
