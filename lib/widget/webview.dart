import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String statusBarColor;
  final String icon;
  final String title;
  final String url;
  final bool hideAppBar;

  const WebView({Key key,
    this.icon,
    this.title,
    this.url,
    this.hideAppBar,
    this.statusBarColor})
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _stateChanged;
  StreamSubscription<WebViewHttpError> _errorWebview;

  @override
  void initState() {
    super.initState();
//    防止重新打开页面
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {
//      监听url跳转
      print(url);
    });
    _stateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
          switch (state.type) {
            case WebViewState.shouldStart:
              break;
            case WebViewState.startLoad:
              break;
            case WebViewState.finishLoad:
              break;
            case WebViewState.abortLoad:
              break;
            default:
              break;
          }
        });
    _errorWebview = webviewReference.onHttpError.listen((WebViewHttpError err) {
//      捕捉错误
      print(err.toString());
    });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _stateChanged.cancel();
    _errorWebview.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
        body: SafeArea(
            top: true,
            child: Column(
              children: <Widget>[
                _appBar(Color(int.parse('0xff' + statusBarColorStr)),
                    backButtonColor),
//          撑满屏幕
                Expanded(
                    child: WebviewScaffold(
                      url: widget.url,
                      withZoom: false,
                      hidden: true,
                      withJavascript: true,
//                  启用本地缓存
                      withLocalStorage: true,
//              初始化界面
                      initialChild: Container(
                        color: Colors.white,
                        child: Center(
                          child: Text('加载网页中'),
                        ),
                      ),
                    ))
              ],
            )));
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    } else {
      return Container(
//        撑满宽度
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    color: backButtonColor,
                    size: 26,
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      widget.title ?? '',
                      style: TextStyle(color: backButtonColor, fontSize: 20),
                    ),
                  ))
            ],
          ),
        ),
      );
    }
  }
}
