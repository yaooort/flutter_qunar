import 'package:flutter/material.dart';
import 'package:flutter_qunar/model/home_entity.dart';
import 'package:flutter_qunar/widget/webview.dart';

// 首页广告区域下面的单独按钮
class SalesBox extends StatelessWidget {
  final HomeSalesbox salesBox;

  const SalesBox({Key key, @required this.salesBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white70),
      child: _items(context),
    );
  }

  _items(BuildContext context) {}
}
