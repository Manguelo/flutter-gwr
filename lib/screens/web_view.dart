import 'package:flutter/material.dart';
import 'package:flutter_gwr/extensions/padding_extensions.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatelessWidget {
  WebView({@required this.url, @required this.title});

  final flutterWebviewPlugin = FlutterWebviewPlugin();
  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 4, title: Text(title)),
      body: WillPopScope(
        onWillPop: killWebView,
        child: WebviewScaffold(
          initialChild: Container(
            color: Colors.white,
          ),
          primary: false,
          hidden: true,
          resizeToAvoidBottomInset: true,
          url: url,
        ),
      ).paddingOnly(top: 10, bottom: 10),
    );
  }

  Future<bool> killWebView() {
    flutterWebviewPlugin
      ..hide()
      ..dispose();
    return Future.value(true);
  }
}
