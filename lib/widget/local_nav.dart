import 'package:flutter/material.dart';
import 'package:flutter_qunar/model/home_entity.dart';
import 'package:flutter_qunar/widget/webview.dart';

// 首页广告区域下面的单独按钮
class LocalNav extends StatelessWidget {
  final List<HomeLocalnavlist> localNavList;

  const LocalNav({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(padding: EdgeInsets.all(7), child: _items(context)),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((model) {
      items.add(_item(context, model));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, HomeLocalnavlist model) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            WebView(url: model.url,
              hideAppBar: model.hideAppBar,
              title: model.title,
              icon: model.icon,
              statusBarColor: model.statusBarColor)
        ));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 32,
            height: 32,
          ),
          Text(
            model.title,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
