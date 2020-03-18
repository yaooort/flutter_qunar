import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

///内建浏览器
class WebView extends StatefulWidget {
  final bool isShowTabBar;
  final bool isShowBack;
  final String title;
  final String url;

  const WebView(
      {Key key,
      this.isShowTabBar,
      this.title,
      this.url,
      this.isShowBack = false})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WebviewScaffold(
      url: widget.url,
      appBar: widget.isShowTabBar
          ? AppBar(
              title: Text(widget.title),
              automaticallyImplyLeading: widget.isShowBack,
            )
          : null,
      withZoom: false,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "正在加载中...",
                style: TextStyle(fontSize: 12, color: Colors.black87),
              )
            ],
          ),
        ),
      ),
    );
  }
}
