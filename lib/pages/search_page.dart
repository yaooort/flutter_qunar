import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_qunar/dao/search_dao.dart';
import 'package:flutter_qunar/model/search_entity.dart';
import 'package:flutter_qunar/widget/search_bar.dart';
import 'package:flutter_qunar/widget/webview_page.dart';

const TYPES = [
  'channelgroup',
  'gs',
  'plane',
  'train',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];
const URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

// 搜索页面
class SearchPage extends StatefulWidget {
  final bool hideLift;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key,
      this.hideLift = true,
      this.searchUrl = URL,
      this.keyword,
      this.hint})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchEntity searchEntity;
  String keyword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar,
          Expanded(
              flex: 1,
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      itemCount: searchEntity?.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int position) {
                        return _item(position);
                      })))
        ],
      ),
    );
  }

  Widget get _appBar {
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
            padding: EdgeInsets.only(right: 10),
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
            child: SafeArea(
                top: true,
                child: SearchBar(
                  hideLeft: widget.hideLift,
                  defaultText: widget.keyword,
                  hint: widget.hint,
                  leftButtonClick: () {
                    Navigator.pop(context);
                  },
                  onChanged: _onTextChange,
                )),
          ),
        ),
        Container(
          height: 0.5,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]),
        )
      ],
    );
  }

  _onTextChange(String text) {
    keyword = text;
    if (text.length == 0) {
      setState(() {
        searchEntity = null;
      });
      return;
    }
    String searchUrl = widget.searchUrl + text;
    SearchDao.fetch(searchUrl, text).then((SearchEntity value) {
      if (value.keyword == text) {
        setState(() {
          searchEntity = value;
        });
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  Widget _item(int position) {
    if (searchEntity == null || searchEntity.data == null) return null;
    SearchData item = searchEntity.data[position];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: item.url,
                      title: "详情",
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(8),
              child: Image.asset(_typeImage(item.type),color: Colors.indigoAccent),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _title(item, searchEntity.keyword),
                      _subTitle(item)
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _typeImage(String type) {
    if (type == null) return "images/type_travelgroup.png";
    String path = 'travelgroup';
    for (final val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  Widget _title(SearchData item, String keyword) {
    List<TextSpan> spans = [];
    if ((item.word ?? '').length != 0) {
      List<String> splits = item.word.split(keyword);
      TextStyle n = TextStyle(fontSize: 16, color: Colors.black87);
      TextStyle l = TextStyle(fontSize: 16, color: Colors.deepOrangeAccent);
      for (int i = 0; i < splits.length; i++) {
        if ((i + 1) % 2 == 0) {
          //高亮
          spans.add(TextSpan(style: l, text: keyword));
        }
        String v = splits[i];
        if (v != null && v.length > 0) {
          //非高亮
          spans.add(TextSpan(style: n, text: v));
        }
      }
    }
    spans.add(TextSpan(
        text: '   ${item.districtname ?? ''}  ',
        style: TextStyle(fontSize: 10, color: Colors.grey)));
    spans.add(TextSpan(
        text: '   ${item.zonename ?? ''}  ',
        style: TextStyle(fontSize: 10, color: Colors.grey)));

    return Text.rich(TextSpan(children: spans));
  }

  Widget _subTitle(SearchData item) {
    List<TextSpan> spans = [];

    spans.add(TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.lightBlue),
        text: '${item.price ?? ''}  '));
    spans.add(TextSpan(
        style: TextStyle(fontSize: 14, color: Colors.grey),
        text: '${item.star ?? ''}  '));

    return RichText(text: TextSpan(children: spans));
  }
}
