import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_qunar/dao/home_dao.dart';
import 'package:flutter_qunar/model/home_entity.dart';
import 'package:flutter_qunar/widget/grid_nav.dart';
import 'package:flutter_qunar/widget/loading_container.dart';
import 'package:flutter_qunar/widget/local_nav.dart';
import 'package:flutter_qunar/widget/sales_box.dart';
import 'package:flutter_qunar/widget/search_bar.dart';
import 'package:flutter_qunar/widget/sub_nav.dart';
import 'package:flutter_qunar/widget/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

// 滚动距离阈值
const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = '网红打卡地 景点 酒店 美食';

// 首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  } //  appbar透明度

  double appBarAlpha = 0;

//  获取首页数据
  String resultString = "";
  HomeEntity model = null;

//  第一种方法
//  loadData() {
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }, onError: (err) {
//      resultString = err.toString();
//    }).catchError((onError) {
//      resultString = onError.toString();
//    });
//  }

  Future<Null> _handleRefresh() async {
    try {
      HomeEntity modelDao = await HomeDao.fetch();
      setState(() {
        model = modelDao;
        resultString = json.encode(model);
        _isloading = false;
      });
    } catch (e) {
      resultString = e.toString();
      _isloading = false;
    }
    return null;
  }

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
    return LoadingContainer(
      rootWidget: Scaffold(
          backgroundColor: Color(0xf3f3f3),
          body: Stack(
            children: <Widget>[
//          页面
              MediaQuery.removePadding(
                  context: context,
//          移除ListView默认的顶部安全区域padding
                  removeTop: true,
                  child: RefreshIndicator(
                      child: NotificationListener(
                        onNotification: (scrollNotification) {
//              滚动列表回调
                          if (scrollNotification is ScrollUpdateNotification &&
                              scrollNotification.depth == 0) {
//                  如果有更新,并且只是深度为一级控件变化的监听，.depth == 0 也就是只监听子控件ListView
                            _onScroll(scrollNotification.metrics.pixels);
                          }
                        },
                        child: _listView,
                      ),
                      onRefresh: _handleRefresh)),
//          AppBar，叠在页面上方,使用Opacity动态改变透明度
              _appbar,
            ],
          )),
      isLoading: _isloading,
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        _banner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNav(
            localNavList: model == null ? [] : model.localNavList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: model == null
              ? null
              : GridNav(
                  gridnav: model.gridNav,
                ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: SubNav(
              subNavList: model == null ? [] : model.subNavList,
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
            child: model == null
                ? null
                : SalesBox(
                    salesBox: model.salesBox,
                  )),
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: model == null ? 0 : model.bannerList.length,
        autoplay: true,
        pagination: SwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WebView(
                        url: model.bannerList[index].url,
                        title: '广告',
                      )));
            },
            child: Image.network(
              model.bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
      ),
    );
  }

  Widget get _appbar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x66000000), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color:
                    Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255)),
            child: SafeArea(
                top: true,
                child: SearchBar(
                  searchBarType: appBarAlpha > 0.2
                      ? SearchBarType.homeLight
                      : SearchBarType.home,
                  inputBoxClick: _jumpToSearch,
                  speakClick: _jumpToSpeak,
                  defaultText: SEARCH_BAR_DEFAULT_TEXT,
                  leftButtonClick: () {},
                )),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );

//      SafeArea(
//        top: true,
//        child: SearchBar(
//          searchBarType:
//              appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
//          inputBoxClick: _jumpToSearch,
//          speakClick: _jumpToSpeak,
//          defaultText: SEARCH_BAR_DEFAULT_TEXT,
//          leftButtonClick: () {},
//        ));
//    Opacity(
//      opacity: appBarAlpha,
//      child: Container(
//        height: 80,
//        decoration: BoxDecoration(color: Colors.white),
//        child: Center(
//          child: Padding(
//            padding: EdgeInsets.only(top: 20),
//            child: Text(
//              '首页',
//            ),
//          ),
//        ),
//      ),
//    )
  }

  get _jumpToSearch => null;

  get _jumpToSpeak => null;
}
