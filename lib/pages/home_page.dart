import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// 滚动距离阈值
const APPBAR_SCROLL_OFFSET = 100;

// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];

//  appbar透明度
  double appBarAlpha = 0;

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    }
    if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
//          页面
        MediaQuery.removePadding(
            context: context,
//          移除ListView默认的顶部安全区域padding
            removeTop: true,
            child: NotificationListener(
              onNotification: (scrollNotification) {
//              滚动列表回调
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
//                  如果有更新,并且只是深度为一级控件变化的监听，.depth == 0 也就是只监听子控件ListView
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 160,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      pagination: SwiperPagination(),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          _imageUrls[index],
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 800,
                    child: Text('你好'),
                  )
                ],
              ),
            )),
//          AppBar，叠在页面上方,使用Opacity动态改变透明度
        Opacity(
          opacity: appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  '首页',
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
