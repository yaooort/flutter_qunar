import 'package:flutter/material.dart';
import 'package:flutter_qunar/pages/home_page.dart';
import 'package:flutter_qunar/pages/my_page.dart';
import 'package:flutter_qunar/pages/search_page.dart';
import 'package:flutter_qunar/pages/travel_page.dart';

// 底部导航
class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;

  // ignore: non_constant_identifier_names
  int _currentIndex = 0;

  final PageController _controller = PageController(
    initialPage: 0,
  );

  _onScroll(offset) {
    final size = MediaQuery.of(context).size;
//    屏幕宽度
    final width = size.width;
//    变化
    var yu = offset % width;
    print(yu / width);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (scrollNotification) {
//              滚动列表回调
          if (scrollNotification is ScrollUpdateNotification &&
              scrollNotification.depth == 0) {
//                  如果有更新,并且只是深度为一级控件变化的监听，.depth == 0 也就是只监听子控件ListView
            _onScroll(scrollNotification.metrics.pixels);
          }
        },
        child: PageView(
//        不使用滑动
//        physics: NeverScrollableScrollPhysics(),
//      滑动监听
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          controller: _controller,
          children: <Widget>[
            HomePage(),
            SearchPage(),
            TravelPage(),
            MyPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _defaultColor,
                ),
                activeIcon: Icon(Icons.home, color: _activeColor),
                title: Text(
                  '首页',
                  style: TextStyle(
                      color: _currentIndex == 0 ? _activeColor : _defaultColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: _defaultColor,
                ),
                activeIcon: Icon(Icons.search, color: _activeColor),
                title: Text(
                  '搜索',
                  style: TextStyle(
                      color: _currentIndex == 1 ? _activeColor : _defaultColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera_alt,
                  color: _defaultColor,
                ),
                activeIcon: Icon(Icons.camera_alt, color: _activeColor),
                title: Text(
                  '旅拍',
                  style: TextStyle(
                      color: _currentIndex == 2 ? _activeColor : _defaultColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: _defaultColor,
                ),
                activeIcon: Icon(Icons.account_circle, color: _activeColor),
                title: Text(
                  '我的',
                  style: TextStyle(
                      color: _currentIndex == 3 ? _activeColor : _defaultColor),
                )),
          ]),
    );
  }
}
