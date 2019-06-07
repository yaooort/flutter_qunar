import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_qunar/dao/search_dao.dart';
import 'package:flutter_qunar/model/search_entity.dart';
import 'package:flutter_qunar/widget/search_bar.dart';
import 'package:flutter_qunar/widget/webview.dart';
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
              padding: EdgeInsets.all(10),
              child: Center(
                child: Image.asset(_typeImage(item.type)),
              ),
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Text.rich(
                      TextSpan(
                        text: '${item.word ?? ''}  ',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                        children: [
                          TextSpan(
                            text: '${item.districtname ?? ''}  ',
                            style: TextStyle(fontSize: 9, color: Colors.grey),
                          ),
                          TextSpan(
                            text: '${item.zonename ?? ''}  ',
                            style: TextStyle(fontSize: 9, color: Colors.grey),
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                      softWrap: true,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '${item.word ?? ''}  ',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        Text(
                          '${item.districtname ?? ''}  ',
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                        Text(
                          '${item.zonename ?? ''}  ',
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '￥${item.price ?? ''}  ',
                          style: TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                        Text(
                          '${item.star ?? ''}  ',
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        )
                      ],
                    )
                  ],
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
}
