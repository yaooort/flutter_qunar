import 'package:flutter/material.dart';
import 'package:flutter_qunar/model/home_entity.dart';
import 'package:flutter_qunar/widget/webview.dart';

// 首页广告区域下面的网格卡片
class GridNav extends StatelessWidget {
  final HomeGridnav gridnav;

  const GridNav({Key key, @required this.gridnav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    PhysicalModel为子元素裁切方式创建圆角
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridnavitems(context),
      ),
    );
  }

  _gridnavitems(BuildContext context) {
    List<Widget> items = [];
    if (gridnav == null) return items;
    if (gridnav.hotel != null) {
      items.add(_gridNavItem(context, gridnav.hotel, true));
    }
    if (gridnav.flight != null) {
      items.add(_gridNavItem(context, gridnav.flight, false));
    }
    if (gridnav.travel != null) {
      items.add(_gridNavItem(context, gridnav.travel, false));
    }
    return items;
  }

  _gridNavItem(
      BuildContext context, HomeGridnavItem gridnavitem, bool isFrist) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridnavitem.mainItem));
    items.add(_doubleItem(context, gridnavitem.item1, gridnavitem.item2, true));
    items.add(_doubleItem(context, gridnavitem.item3, gridnavitem.item4, true));
    List<Widget> exanditems = [];
    items.forEach((item) {
      exanditems.add(Expanded(child: item, flex: 1));
    });
    Color startColor = Color(int.parse('0xff' + gridnavitem.startColor));
    Color endColor = Color(int.parse('0xff' + gridnavitem.endColor));
    return Container(
      height: 88,
      margin: isFrist ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          //渐变
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: exanditems,
      ),
    );
  }

  _mainItem(BuildContext context, GridMainItem mainItem) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebView(
                url: mainItem.url,
                hideAppBar: mainItem.hideAppBar,
                title: mainItem.title,
                statusBarColor: mainItem.statusBarColor)));
      },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Image.network(
            mainItem.icon,
            fit: BoxFit.contain,
            height: 88,
            width: 121,
            alignment: AlignmentDirectional.bottomCenter,
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              mainItem.title,
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  _doubleItem(BuildContext context, GridItemCard topCard,
      GridItemCard bottomCard, bool isCenter) {
    return Column(
      children: <Widget>[
        Expanded(child: _item(context, topCard, true, isCenter)),
        Expanded(child: _item(context, bottomCard, false, isCenter))
      ],
    );
  }

  _item(BuildContext context, GridItemCard card, bool isFirst, bool isCenter) {
    BorderSide boderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: boderSide,
            bottom: isFirst ? boderSide : BorderSide.none,
          ),
        ),
        child: _warpGesture(
            context,
            Center(
                child: Text(
              card.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.white),
            )),
            card),
      ),
    );
  }

  _warpGesture(BuildContext context, Widget widget, GridItemCard card) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebView(
                url: card.url,
                hideAppBar: card.hideAppBar,
                title: card.title,
                statusBarColor: card.statusBarColor)));
      },
      child: widget,
    );
  }
}
